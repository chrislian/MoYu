//
//  BaseController.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nav = self.navigationController{
            nav.navigationBar.tintColor = UIColor.mo_lightBlack()
        }
    }
    
    //MARK: - event response
    
    //MARK: - private method
    
    //MARK: - public method
    
    //MARK: - var & let

}
