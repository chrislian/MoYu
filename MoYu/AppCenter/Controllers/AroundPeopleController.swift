//
//  AroundPeopleController.swift
//  MoYu
//
//  Created by lxb on 2016/12/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AroundPeopleController: UIViewController,PraseErrorType,AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "附近的人")
        
        setupView()
        
        addRefreshView()
        beginRefresh()
    }
    
    
    //MARK: - private method
    private func setupView(){
        
        view.backgroundColor = UIColor.mo_background
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.mo_background
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func loadRemoteData(page:Int){
        
        Router.aroundPeople(page: page, location: UserManager.sharedInstance.currentLocation).request {[weak self] (status, json) in
            
            guard let strongSelf = self else{ return }
            
            strongSelf.show(error: status)
            
            strongSelf.endRefresh()
            
            guard case .success = status, let json = json else{ return }
            
            let models = json["reslist"].arrayValue.map ( AroundPeopleModel.init )
            
            if models.count == MoDefaultLoadMoreCount{
                strongSelf.canLoadMore = true
            }else{
                strongSelf.canLoadMore = false
            }
            
            if page == 1{
                strongSelf.models = models
            }else{
                strongSelf.models += models
            }
            strongSelf.tableView.reloadData()
        }
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    
    var models:[AroundPeopleModel] = []
    
    var canLoadMore = false
    
    var currentPage = 1
}

extension AroundPeopleController: RefreshViewType{
    
    var refreshScrollView:UIScrollView{
        return self.tableView
    }
    
    func refreshAction() {
        currentPage = 1
        
        loadRemoteData(page: currentPage)
    }
}


// MARK: - UITableViewDelegate
extension AroundPeopleController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if canLoadMore && (indexPath.row >= models.count - 8)
            && models.count >= MoDefaultLoadMoreCount {
            currentPage += 1
            self.loadRemoteData(page:currentPage)
        }
        
        guard let cell = cell as? AroundPeopleCell else{ return }
        
        cell.update(model: models[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: SB.AppCenter.Segue.socialNavi, sender: models[indexPath.row])
        
    }
}


// MARK: - UITableViewDataSource
extension AroundPeopleController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return AroundPeopleCell.cell(tableView: tableView)
    }
}
