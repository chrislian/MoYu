//
//  ParttimeJobManagerController.swift
//  MoYu
//
//  Created by Chris on 16/8/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

enum JobManagerCellType{
    
    case postParttime(model:MyPostPartTimeJob), postTask(model:MyPostTaskJob)
    case getParttime(model:MyGetPartTimeJob), getTask(model:MyGetTaskJob)
}

enum ParttimeJobType: Int {
    case recurit = 1//接收的任务和兼职
    case announce//发布的任务和兼职
}


class ParttimeJobManagerController: UIViewController, PraseErrorType,AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "兼职管理")
        
        mo_rootLeftBackButton()
        
        setupView()

        loadMoreData(page: currentPage)
    }
    
    //MARK: - event response
    func backButton(tap sender:AnyObject){
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - private method
    fileprivate func loadMoreData(page:Int){
        
        func appendData(page:Int, datas:[JobManagerCellType]){
            
            if datas.count < MoDefaultLoadMoreCount{
                canLoadMore = false
            }else{
                canLoadMore = true
            }
            
            if page == 1{
                modelArray.removeAll()
            }
            modelArray.append(contentsOf: datas)
            parttimeJobView.tableView.reloadData()
        }
        
        switch myJobType{
        case .recurit:
            Router.myTaskList(page: page).request{ [weak self](status, json) in
                
                self?.show(error: status)
                if case .success = status, let json = json{
                    let parttimes = json["reslist"]["parttimejob"].arrayValue
                        .map( MyGetPartTimeJob.init )
                        .map( JobManagerCellType.getParttime )
                    
                    let tasks = json["reslist"]["task"].arrayValue
                        .map( MyGetTaskJob.init )
                        .map( JobManagerCellType.getTask )
                    
                    appendData(page: page, datas: parttimes + tasks)
                }
            }
        case .announce:
            Router.myParttimeJobList(page: page).request { [weak self] (status, json) in
                
                self?.show(error: status)
                
                if case .success = status , let json = json {
                    
                    let parttimes = json["reslist"]["parttimejob"].arrayValue
                        .map( MyPostPartTimeJob.init )
                        .map( JobManagerCellType.postParttime )
                    
                    let tasks = json["reslist"]["task"].arrayValue
                        .map( MyPostTaskJob.init )
                        .map( JobManagerCellType.postTask )
                    
                    appendData(page: page, datas: parttimes + tasks)
                }
            }
        }
    }
    
    fileprivate func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background
        parttimeJobView.backgroundColor = UIColor.mo_background
        
        parttimeJobView.tableView.delegate = self
        parttimeJobView.tableView.dataSource = self
        parttimeJobView.tableView.rowHeight = 145
        parttimeJobView.tableView.sectionHeaderHeight = 8
        parttimeJobView.tableView.sectionFooterHeight = 0.01
        
        parttimeJobView.changeButtonType = { [weak self] type in
            self?.myJobType = type
        }
    }
    
    //MARK: - var & let
    @IBOutlet var parttimeJobView: ParttimeJobView!
    
    fileprivate var currentPage = 1{
        didSet{
            loadMoreData(page: currentPage)
        }
    }
    
    fileprivate var myJobType = ParttimeJobType.recurit {
        didSet{
            currentPage = 1;
        }
    }
    
    fileprivate var modelArray:[JobManagerCellType] = []
    fileprivate var canLoadMore = false
}

// MARK: - UITableViewDelegate
extension ParttimeJobManagerController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if canLoadMore && ((indexPath as NSIndexPath).row >= modelArray.count - 3)
            && modelArray.count >= MoDefaultLoadMoreCount {
            
            currentPage += 1
            canLoadMore = false
        }
        
        guard let cell = cell as? ParttimeJobCell else{ return }
    
        cell.update(cellType: modelArray[indexPath.section])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ParttimeJobManagerController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ParttimeJobCell.cell(tableView: tableView)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

