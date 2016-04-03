//
//  MOLeftMenu.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOLeftMenuView: MOBaseView {

    
    override func awakeFromNib() {
        tableView.tableFooterView = UIView()
        
        headerImageView.layer.cornerRadius = headerImageView.bounds.size.height/2.0
        headerImageView.layer.masksToBounds = true
        
        headerImageView.layer.borderColor = UIColor.whiteColor().CGColor
        headerImageView.layer.borderWidth = 2.0
    }
    
    //MARK: - public method
    func updateUserHead(headerImage:UIImage,username:String,phone:String) {
        headerImageView.image = headerImage
        headerUsernameLabel.text = username
        headerPhoneLabel.text = phone
    }

    //MARK: - var & let
    var isMerchantAuth = false {
        didSet{
            if isMerchantAuth != oldValue {
                print("merchantAuth = \(isMerchantAuth)")
            }
        }
    }
    
    var isCustomerAuth = false {
        didSet{
            if isCustomerAuth != oldValue {
                print("customerAuth = \(isCustomerAuth)")
            }
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerCustomAuthLabel: UIImageView!
    @IBOutlet weak var headerMerchantAuthLabel: UIImageView!
    @IBOutlet weak var headerUsernameLabel: UILabel!
    @IBOutlet weak var headerPhoneLabel: UILabel!
}
