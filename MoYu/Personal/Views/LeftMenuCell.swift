//
//  MOLeftMenu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class LeftMenuView: UIView {

    
    override func awakeFromNib() {
        
        self.setupView()
    }
    
    //MARK: - public method

    func updateHeader(user:UserInfo){
        
        headerUsernameLabel.text = user.moName
        headerPhoneLabel.text = user.moPhone
        
       headerImageView.mo_loadImage(user.avatorUrl)
//        headerImageView.image = UIImage(named: "defaultAvator")
    }
    
//    func update(avator image:UIImage){
//        headerImageView.image = image
//    }
    
    fileprivate func setupView(){
        
        headerImageView.layer.cornerRadius = headerImageView.bounds.size.height/2.0
        headerImageView.layer.masksToBounds = true
        
        headerBackView.layer.cornerRadius = headerBackView.bounds.size.height/2.0
        headerBackView.layer.masksToBounds = true
        headerBackView.layer.borderColor = UIColor.white.cgColor
        headerBackView.layer.borderWidth = 2.0
        
        //tableView
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        //auth
        isMerchantAuth = false
        isCustomerAuth = false
    }

    fileprivate func updateAuthImageView(_ imageView:UIImageView,flag:Bool){
        var color:UIColor
        if flag {
           color = UIColor.mo_main
        }else{
            color = UIColor.mo_mercury
        }
        
        guard let image = imageView.image else{
            return
        }
        imageView.image? = image.mo_changeColor(color)
    }
    
    
    //MARK: - var & let
    var isMerchantAuth = true {
        didSet{
            if isMerchantAuth != oldValue {
                self.updateAuthImageView(headerMerchantAuthImageView, flag: isMerchantAuth)
            }
        }
    }
    
    var isCustomerAuth = true {
        didSet{
            if isCustomerAuth != oldValue {
                self.updateAuthImageView(headerCustomAuthImageView, flag: isCustomerAuth)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet fileprivate weak var headerView: UIView!
    @IBOutlet fileprivate weak var headerBackView: UIView!
    @IBOutlet fileprivate weak var headerImageView: UIImageView!
    @IBOutlet fileprivate weak var headerCustomAuthImageView: UIImageView!
    @IBOutlet fileprivate weak var headerMerchantAuthImageView: UIImageView!
    @IBOutlet fileprivate weak var headerUsernameLabel: UILabel!
    @IBOutlet fileprivate weak var headerPhoneLabel: UILabel!
}
