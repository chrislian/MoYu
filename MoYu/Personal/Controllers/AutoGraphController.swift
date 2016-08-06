//
//  AutoGraphController.swift
//  MoYu
//
//  Created by Chris on 16/8/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AutoGraphController: BaseController, PraseErrorType {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigation(title: "个性签名")
        
        self.layout()
        
        self.setupView()
    }
    
    //MARK: - event response
    @objc private func rightBarButtonClick(sender:UIButton){
        
        guard let autograph = self.autographTextField.text where !autograph.isEmpty else{
            self.showError(message: "什么都没说呢~")
            return
        }
        
        Router.updateAutograph(string: autograph).request { (status, json) in
            
            if let data = json ,case .success = status{
                UserManager.sharedInstance.update(user: data, phone: UserManager.sharedInstance.user.phonenum)
                self.navigationController?.popViewControllerAnimated(true)
                NSNotificationCenter.defaultCenter().postNotificationName(UserNotification.updateUserInfo, object: nil)
            }else{
                self.showError(status)
            }
        }
    }
    
    //MARK: - private method
    
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Done, target:self, action: #selector(rightBarButtonClick(_:)))
        
        autographTextField.delegate = self
        if !autographTextField.isFirstResponder(){
            autographTextField.becomeFirstResponder()
        }
        
        if !autograph.isEmpty{
            autographTextField.text = autograph
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
        
        containerView.addSubview(autographTextField)
        autographTextField.snp_makeConstraints { (make) in
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
    private let autographTextField:UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.mo_font()
        textfield.textColor = UIColor.mo_lightBlack()
        textfield.placeholder = "说点什么吧~"
        return textfield
    }()
    
    private let promptLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .Left
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = ""
        return label
    }()
    
    var autograph:String = ""
}

extension AutoGraphController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > 40{
            textField.text = text.substringToIndex(40)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.stringByReplacingCharactersInRange(range, withString: string)
        if toBeString.characters.count > 40{
            textField.text = (toBeString as NSString).substringToIndex(40)
            return false
        }
        return true
    }
}
