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
    
    func remoteData(page page:Int, clourse:RemoteClourse){
        
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
    private func setupView(){
        
        view.backgroundColor = UIColor.mo_background()
        
        view.addSubview(tableView)
        tableView.frame = CGRect(origin: CGPoint(x: 0,y: -32), size: CGSize(width: MoScreenWidth, height: view.frame.size.height - 50))
    }

    //MARK: - var & let
    
    var currentPage:Int = 1
    
    var taskDetailType = TaskDetailType.all
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .Grouped)
        tableView.backgroundColor = UIColor.mo_background()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: String(TaskDetailCell), bundle: nil),
                              forCellReuseIdentifier: TaskDetailCell.identifier)
        return tableView
    }()
    
    var taskItems:[TaskModel] = []
    
    var canLoadMore = false
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
    
    private func loadMoreData(page page:Int){
        
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
                self?.taskItems.appendContentsOf( array )
            }
            
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension TaskDetailController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
       //load more
        if self.canLoadMore && (indexPath.section >= taskItems.count - 3)
            && taskItems.count >= MoDefaultLoadMoreCount {
            
            currentPage += 1
            loadMoreData(page: currentPage)
        }
        
        guard let cell = cell as? TaskDetailCell else{ return }
        cell.update(item: taskItems[indexPath.section] )
        cell.selectionStyle = .None
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor ( red: 0.0, green: 0.251, blue: 0.502, alpha: 1.0 )
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension TaskDetailController:UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return taskItems.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return TaskDetailCell.cell(tableView: tableView)
    }
}
