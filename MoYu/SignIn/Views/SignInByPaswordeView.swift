//
//  SignInByPhoneView.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class SignInByPasswordView: UIView {

    
    override func awakeFromNib() {
        
        self.setupView()
    }
    
    //MARK: - private method
    private func setupView(){
        
        headView.layer.cornerRadius = headView.frame.size.height/2
        headView.layer.masksToBounds = true
        headView.layer.borderColor = UIColor.whiteColor().CGColor
        headView.layer.shadowOffset = CGSize(width: 5, height: 5)
        headView.layer.shadowColor = UIColor.mo_main().CGColor
        headView.layer.borderWidth = 0.8
        headView.backgroundColor = UIColor.clearColor()
        
        headImageView.layer.cornerRadius = headImageView.frame.size.height/2
        headImageView.layer.masksToBounds = true
        
        enterButton.layer.cornerRadius = enterButton.bounds.size.height/2
        enterButton.layer.masksToBounds = true
        enterButton.titleLabel?.font = UIFont.mo_font(.bigger)
        enterButton.titleLabel?.textColor = UIColor.whiteColor()
        enterButton.backgroundColor = UIColor.mo_main()
        
        userNameView.backgroundColor = UIColor ( red: 1.0, green: 0.8, blue: 0.4, alpha: 0.2 )
        userNameView.layer.cornerRadius = userNameView.bounds.size.height/2
        userNameView.layer.masksToBounds = true
        
        passwordCodeView.backgroundColor = UIColor ( red: 1.0, green: 0.8, blue: 0.4, alpha: 0.2 )
        passwordCodeView.layer.cornerRadius = passwordCodeView.bounds.size.height/2
        passwordCodeView.layer.masksToBounds = true
        
        
        userTextfield.textColor = UIColor.whiteColor()
        userTextfield.placeholder = "请输入您的手机号码"
        userTextfield.font = UIFont.mo_font(.smaller)
        
        passwordTextFiled.textColor = UIColor.whiteColor()
        passwordTextFiled.placeholder = "6-25位字母、数字或下划线"
        passwordTextFiled.font = UIFont.mo_font(.smaller)
        
        userProtocolButton.titleLabel?.font = UIFont.mo_font()
        userProtocolButton.setTitle("用户协议", forState: .Normal)
        userProtocolButton.setTitleColor(UIColor.mo_main(), forState: .Normal)
        
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordCodeView: UIView!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userTextfield: UITextField!
    
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var userProtocolButton: UIButton!
}
