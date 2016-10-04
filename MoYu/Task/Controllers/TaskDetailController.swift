//
//  TaskDetailController.swift
//  MoYu
//
//  Created by Chris on 16/9/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


enum TaskDetailType:Int {
    case all = 0, appExperience, handbill, other
    
    func remoteData(page:Int, clourse:@escaping RemoteClourse){
        
        switch self {
        case .all:
            Router.allTask(page: page).request(remote: clourse)
        default:
            Router.taskCategory(type: self, page: page).request(remote: clourse)
        }
    }
}

class TaskDetailController: UIViewController,PraseErrorType,AlertViewType {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        addRefreshView()
        beginRefresh()
    }
    
    
    
    //MARK: - private method
    fileprivate func setupView(){
        
        view.backgroundColor = UIColor.mo_background()
        
        view.addSubview(tableView)
        tableView.frame = CGRect(origin: CGPoint(x: 0,y: -32), size: CGSize(width: MoScreenWidth, height: view.frame.size.height - 50))
//        tableView.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalTo(view)
//        }
    }

    //MARK: - var & let
    
    var currentPage:Int = 1
    
    var taskDetailType = TaskDetailType.all
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.mo_background()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        tableView.register(UINib(nibName: String(describing: TaskDetailCell.self), bundle: nil),
                              forCellReuseIdentifier: TaskDetailCell.identifier)
        return tableView
    }()
    
    var taskItems:[TaskModel] = []
    
    var canLoadMore = false
    
    var selectClourse:((_ type:TaskDetailType, _ model:TaskModel)->Void)?
}

// MARK: - RefreshViewType
extension TaskDetailController: RefreshViewType{

    //refresh
    var refreshScrollView: UIScrollView {
        return self.tableView
    }
    
    func refreshAction() {
        
        currentPage = 1
        
        loadMoreData(page: currentPage)
        
    }
    
    fileprivate func loadMoreData(page:Int){
        
        taskDetailType.remoteData(page: page) {[weak self] (status, json) in
            
            self?.endRefresh()
            
            self?.show(error: status)
            
            guard case .success = status, let data = json?["reslist"].array else{ return }
            
            let array = data.map( TaskModel.init )
            
            if array.count < MoDefaultLoadMoreCount{
                self?.canLoadMore = false
            }else{
                self?.canLoadMore = true
            }
            
            if page == 1{
                self?.taskItems = array
            }else{
                self?.taskItems.append( contentsOf: array )
            }
            
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension TaskDetailController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
       //load more
        if self.canLoadMore && ((indexPath as NSIndexPath).section >= taskItems.count - 3)
            && taskItems.count >= MoDefaultLoadMoreCount {
            
            currentPage += 1
            loadMoreData(page: currentPage)
        }
        
        guard let cell = cell as? TaskDetailCell else{ return }
        cell.update(item: taskItems[(indexPath as NSIndexPath).section] )
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectClourse?(taskDetailType, taskItems[(indexPath as NSIndexPath).section])
        
    }
}

// MARK: - UITableViewDataSource
extension TaskDetailController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return TaskDetailCell.cell(tableView: tableView)
    }
}
