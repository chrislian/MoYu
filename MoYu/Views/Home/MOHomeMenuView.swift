//
//  MOMOHomeMenu.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOHomeMenuView: UIView {

    
    override func awakeFromNib() {
        
        setupView()
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.backgroundColor = UIColor.mo_main()
        titleView.backgroundColor = UIColor.mo_main()
        searchBar.backgroundImage = UIImage()
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
}
