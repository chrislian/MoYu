//
//  AccountBindingCell.swift
//  MoYu
//
//  Created by Chris on 16/7/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AccountBindingCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupCell()
    }
    
    
    //MARK: - event response
    func bindingButtonClicked(_ sender:UIButton){
        
        guard let type = AccountType(rawValue: sender.tag) else { return }
        
        self.bindingButtonClick?(type)
    }

    //MARK: - public method
    func update(acount item:AccountItem){
        if item.isBinding{
            if item.type == .phone{
                bindingButton.setTitle("修改", for: UIControlState())
            }
            bindingButton.setTitle("解绑", for: UIControlState())
            bindingButton.setTitleColor(UIColor.mo_silver, for: UIControlState())
            bindingButton.layer.borderColor = UIColor.mo_silver.cgColor
        }else{
            bindingButton.setTitleColor(UIColor.mo_main, for: UIControlState())
            bindingButton.setTitle("绑定", for: UIControlState())
            bindingButton.layer.borderColor = UIColor.mo_main.cgColor
        }
        let image:UIImage?
        switch item.type {
        case .qq:
            image = item.isBinding ? UIImage(named: "icon_qq_light") : UIImage(named: "icon_qq_grey")
        case .weChat:
            image = item.isBinding ? UIImage(named: "icon_wechat_light") : UIImage(named: "icon_wechat_grey")
        case .weibo:
            image = item.isBinding ? UIImage(named: "icon_weibo_light") : UIImage(named: "icon_weibo_grey")
        case .phone:
            image = item.isBinding ? UIImage(named: "icon_phone_light") : UIImage(named: "icon_phone_grey")
        }
        
        bindingButton.tag = item.type.rawValue
        bindingButton.addTarget(self, action: #selector(bindingButtonClicked(_:)), for: .touchUpInside)
        
        accountImageView.image = image
        accountStatusLabel.text = item.status
        accountNameLabel.text = item.name
    }
    
    //MARK: - private method
    fileprivate func setupCell(){
        accountImageView.contentMode = .scaleAspectFill
        accountImageView.layer.cornerRadius = accountImageView.frame.size.width/2
        accountImageView.layer.masksToBounds = true
        
        accountNameLabel.font = UIFont.mo_font()
        accountNameLabel.textColor = UIColor.mo_lightBlack
        accountNameLabel.text = "墨鱼"
    
        accountStatusLabel.font = UIFont.mo_font()
        accountStatusLabel.textColor = UIColor.mo_main
        
        bindingButton.layer.borderWidth = 1
        bindingButton.layer.cornerRadius = bindingButton.frame.size.height/2
        bindingButton.layer.masksToBounds = true
    }
    
    
    //MARK: - var & let
    
    var bindingButtonClick:((_ type:AccountType)->Void)?
    
    @IBOutlet weak var bindingButton: UIButton!
    @IBOutlet weak var accountStatusLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountImageView: UIImageView!
}
