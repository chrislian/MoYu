//
//  HomeMenuController.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeMenuController: BaseController,RefreshViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuView()
        
        addRefreshView()
        
        loadMoreData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        self.navigationController?.navigationBar.hidden = false
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == SB.Main.Segue.selectCity,
            let vc = segue.destinationViewController as? SelectCityController{
            vc.changeCityClourse = { [unowned self] city in
                self.currentCity = city
            }
        }
    }


    //MARK: - event reponse
    @IBAction func leftButtonClicked(sender: UIButton) {
        self.performSegueWithIdentifier(SB.Main.Segue.selectCity, sender: nil)
    }
    
    @IBAction func rightButtonClicked(sender: UIButton) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func headViewButtonClicked(sender: UIButton) {
        println("sender.tag = \(sender.tag)")
        
    }
    
    private func setupMenuView(){
        
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        menuView.tableView.rowHeight = 80.0
    }
    
    func refreshAction() {
        
        self.currentPage = 1
        
        loadMoreData()
    }
    
    private func loadMoreData(){
        
        Router.allPartTimeJobList(page: currentPage, location: location).request { [weak self] (status, json) in
            
            
            guard let strongSelf = self else { return }
            
            strongSelf.endRefresh()
            
            strongSelf.show(error: status)
            
            if case .success = status, let data = json?["reslist"].array{
                
                let array = data.map( HomeMenuModel.init )
                
                if array.count < MoDefaultLoadMoreCount{
                    strongSelf.canLoadMore = false
                }else{
                    strongSelf.canLoadMore = true
                }
                
                if strongSelf.currentPage == 1{
                    strongSelf.modelArray = array
                }else{
                    strongSelf.modelArray.appendContentsOf(array)
                }
                
                strongSelf.menuView.tableView.reloadData()
            }
        }
    }
    

    //MARK: - var & let
    @IBOutlet var menuView: HomeMenuView!
    
    lazy var refreshScrollView: UIScrollView = self.menuView.tableView
    
    var modelArray : [HomeMenuModel] = []
    var location = MoYuLocation()
    
    private var canLoadMore = true
    private var currentPage = 1
    
    private var currentCity = "厦门" {
        willSet{
            menuView.cityLabel.text = newValue
        }
    }
}

extension HomeMenuController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if self.canLoadMore && (indexPath.row >= modelArray.count - 3)
            && modelArray.count >= MoDefaultLoadMoreCount {
            self.currentPage += 1
            self.loadMoreData()
        }
        
        guard let tmpCell = cell as? HomeMenuCell else{
            return
        }
        tmpCell.update(item: modelArray[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = BaseController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeMenuController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return modelArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return HomeMenuCell.cell(tableView: tableView)
    }
}


