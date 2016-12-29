//
//  HomeSearchView.swift
//  MoYu
//
//  Created by Chris on 16/4/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeSearchView: UIView {

   
    override func awakeFromNib() {
        
        setupView()
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = UIColor.mo_main
        
        tableView.backgroundColor = UIColor.mo_background
        tableView.tableHeaderView = headView
    }
    
    //MARK: - var & let
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    lazy var headView = HotSearchView(frame:CGRect(x: 0, y: 0, width: MoScreenWidth, height: 200))
    
    
}


