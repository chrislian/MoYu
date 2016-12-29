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
    @objc fileprivate func rightBarItem(tap sender:AnyObject){
        
        guard let nickname = self.nicknameTextField.text , !nickname.isEmpty else{
            self.showAlert(message: "昵称不能为空")
            return
        }
        
        Router.updateNickname(name: nickname).request { (status, json) in
            
            self.updateUser(status, json: json)
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - private method
    
    fileprivate func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background
        
        let rightBarButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(rightBarItem(tap:)))
        navigationItem.rightBarButtonItem = rightBarButton
        
        nicknameTextField.delegate = self
        if !nicknameTextField.isFirstResponder{
            nicknameTextField.becomeFirstResponder()
        }
        
        if !nickname.isEmpty{
            nicknameTextField.text = nickname
        }
    }
    
    fileprivate func layout(){

        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(10)
            make.left.right.equalTo(self.view)
            make.bottom.lessThanOrEqualTo(self.view)
        }
        
        containerView.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(containerView).offset(20)
            make.top.bottom.right.equalTo(containerView)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(containerView.snp.bottom).offset(5)
            make.right.equalTo(self.view)
        }
    }
    
    //MARK: - var & let
    fileprivate let nicknameTextField:UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.mo_font()
        textfield.textColor = UIColor.mo_lightBlack
        textfield.placeholder = "昵称是身份的象征"
        return textfield
    }()
    
    fileprivate let promptLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font(.smaller)
        label.text = "好的名字可以让你的朋友更容易记住你哦~"
        return label
    }()
    
    var nickname:String = ""
}

extension ChangeNicknameController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > 12{
            textField.text = text.substring(to: 12)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.replacingCharacters(in: range, with: string)
        if toBeString.characters.count > 12{
            textField.text = (toBeString as NSString).substring(to: 12)
            return false
        }
        return true
    }
}

