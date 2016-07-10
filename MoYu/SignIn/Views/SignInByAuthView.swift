//
//  SignInByAuthView.swift
//  MoYu
//
//  Created by Chris on 16/7/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class SignInByAuthView: UIView {

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
        
        authCodeView.backgroundColor = UIColor ( red: 1.0, green: 0.8, blue: 0.4, alpha: 0.2 )
        authCodeView.layer.cornerRadius = authCodeView.bounds.size.height/2
        authCodeView.layer.masksToBounds = true
        
        authButton.setTitle("获取验证码", forState: .Normal)
        authButton.titleLabel?.font = UIFont.mo_font(.smallest)
        authButton.setTitleColor(UIColor.mo_main(), forState: .Normal)
        authButton.layer.cornerRadius = authButton.bounds.size.height/2
        authButton.layer.borderWidth = 0.8
        authButton.layer.borderColor = UIColor.mo_main().CGColor
        authButton.layer.masksToBounds = true
        
        userTextfield.textColor = UIColor.whiteColor()
        userTextfield.placeholder = "请输入您的手机号码"
        userTextfield.font = UIFont.mo_font(.smaller)
        
        authTextFiled.textColor = UIColor.whiteColor()
        authTextFiled.placeholder = "验证码"
        authTextFiled.font = UIFont.mo_font(.smaller)
        
        enterByPasswordButton.titleLabel?.font = UIFont.mo_font()
        enterByPasswordButton.titleLabel?.textColor = UIColor.whiteColor()
        enterByPasswordButton.setTitle("密码登录", forState: .Normal)
        
        userProtocolButton.titleLabel?.font = UIFont.mo_font()
        userProtocolButton.titleLabel?.textColor = UIColor.whiteColor()
        userProtocolButton.setTitle("用户协议", forState: .Normal)
        
        orLabel.font = UIFont.mo_font(.smallest)
    }
    

    //MARK: - var & let
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var authCodeView: UIView!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userTextfield: UITextField!
    
    @IBOutlet weak var authImageView: UIImageView!
    @IBOutlet weak var authTextFiled: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    @IBOutlet weak var enterByPasswordButton: UIButton!
    @IBOutlet weak var userProtocolButton: UIButton!
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var orLabel: UILabel!
    
}
