//
//  HomeSearchController.swift
//  MoYu
//
//  Created by Chris on 16/4/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeSearchController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.hidden = false
    }
    

    //MARK: - event response
    
//    @IBAction func cancelButtonClicked(sender: UIButton) {
//        
//        self.view.endEditing(true)
//        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
//    }
  
    //MARK: - private method
    private func setupView(){
        seachView.searchBar.delegate = self
        
        seachView.tableView.delegate = self
        seachView.tableView.dataSource = self
        
        seachView.headView.collectionView.delegate = self
        seachView.headView.collectionView.dataSource = self
        
    }
    
    //MARK: - var & let

    @IBOutlet var seachView: HomeSearchView!
    
}


extension HomeSearchController:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

extension HomeSearchController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.textLabel?.text = "test"
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}

extension HomeSearchController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "homeSearchIndentifier"
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else{
            
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            
        }
        
        return cell
    }
}

extension HomeSearchController:UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = cell as? HotSearchMenuCell else{ return }
        
        cell.imageView.image = UIImage(named: "defalutHead")
        cell.textLabel.text = "菜单";
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension HomeSearchController:UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "hotSearchCellIndentifier"
        return collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
    }
}

extension HomeSearchController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(80, 80)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}
