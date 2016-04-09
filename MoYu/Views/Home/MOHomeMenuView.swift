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
        
        self.backgroundColor = UIColor.mo_mainColor()
        titleView.backgroundColor = UIColor.mo_mainColor()
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
}
