//
//  ChangeNicknameController.swift
//  MoYu
//
//  Created by Chris on 16/8/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class ChangeNicknameController: UIViewController,PraseErrorType,AlertViewType {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mo_navigationBar(title: "修改昵称")
        
        self.layout()
        
        self.setupView()
    }
    
    //MARK: - event response
    @objc private func rightBarItem(tap sender:AnyObject){
        
        guard let nickname = self.nicknameTextField.text where !nickname.isEmpty else{
            self.showAlert(message: "昵称不能为空")
            return
        }
        
        Router.updateNickname(name: nickname).request { (status, json) in
            
            self.updateUser(status, json: json)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    //MARK: - private method
    
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        
        let rightBarButton = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(rightBarItem(tap:)))
        navigationItem.rightBarButtonItem = rightBarButton
        
        nicknameTextField.delegate = self
        if !nicknameTextField.isFirstResponder(){
            nicknameTextField.becomeFirstResponder()
        }
        
        if !nickname.isEmpty{
            nicknameTextField.text = nickname
        }
    }
    
    private func layout(){

        let containerView = UIView()
        containerView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(10)
            make.left.right.equalTo(self.view)
            make.bottom.lessThanOrEqualTo(self.view)
        }
        
        containerView.addSubview(nicknameTextField)
        nicknameTextField.snp_makeConstraints { (make) in
            make.left.equalTo(containerView).offset(20)
            make.top.bottom.right.equalTo(containerView)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(promptLabel)
        promptLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(containerView.snp_bottom).offset(5)
            make.right.equalTo(self.view)
        }
    }
    
    //MARK: - var & let
    private let nicknameTextField:UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.mo_font()
        textfield.textColor = UIColor.mo_lightBlack()
        textfield.placeholder = "昵称是身份的象征"
        return textfield
    }()
    
    private let promptLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .Left
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = "好的名字可以让你的朋友更容易记住你哦~"
        return label
    }()
    
    var nickname:String = ""
    
    //mark
    var alertView: OLGhostAlertView = OLGhostAlertView()
    var alertLock: NSLock = NSLock()
}

extension ChangeNicknameController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > 12{
            textField.text = text.substringToIndex(12)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.stringByReplacingCharactersInRange(range, withString: string)
        if toBeString.characters.count > 12{
            textField.text = (toBeString as NSString).substringToIndex(12)
            return false
        }
        return true
    }
}

