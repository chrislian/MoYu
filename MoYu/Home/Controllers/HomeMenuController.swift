//
//  HomeMenuController.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeMenuController: UIViewController,RefreshViewType ,PraseErrorType, AlertViewType{

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuView()
        
        addRefreshView()
        
        loadMoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SB.Main.Segue.selectCity,
            let vc = segue.destination as? SelectCityController{
            vc.changeCityClourse = { [unowned self] city in
                self.currentCity = city
            }
        }
    }


    //MARK: - event reponse
    @IBAction func leftButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: SB.Main.Segue.selectCity, sender: nil)
    }
    
    @IBAction func rightButtonClicked(_ sender: UIButton) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func headViewButtonClicked(_ sender: UIButton) {
        println("sender.tag = \(sender.tag)")
        
    }
    
    fileprivate func setupMenuView(){
        
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        menuView.tableView.rowHeight = 80.0
    }
    
    func refreshAction() {
        
        self.currentPage = 1
        
        loadMoreData()
    }
    
    fileprivate func loadMoreData(){
        
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
                    strongSelf.modelArray.append(contentsOf: array)
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
    
    fileprivate var canLoadMore = true
    fileprivate var currentPage = 1
    
    fileprivate var currentCity = "厦门" {
        willSet{
            menuView.cityLabel.text = newValue
        }
    }
}

extension HomeMenuController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if self.canLoadMore && ((indexPath as NSIndexPath).row >= modelArray.count - 3)
            && modelArray.count >= MoDefaultLoadMoreCount {
            self.currentPage += 1
            self.loadMoreData()
        }
        
        guard let tmpCell = cell as? HomeMenuCell else{
            return
        }
        tmpCell.update(item: modelArray[(indexPath as NSIndexPath).row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeMenuController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return modelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return HomeMenuCell.cell(tableView: tableView)
    }
}


