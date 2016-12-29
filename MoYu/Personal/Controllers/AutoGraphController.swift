//
//  AutoGraphController.swift
//  MoYu
//
//  Created by Chris on 16/8/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AutoGraphController: UIViewController, PraseErrorType, AlertViewType {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mo_navigationBar(title: "个性签名")
        
        self.layout()
        
        self.setupView()
    }
    
    //MARK: - event response
    @objc fileprivate func rightBarItem(tap sender:AnyObject){
        
        guard let autograph = self.autographTextField.text , !autograph.isEmpty else{
            self.showAlert(message: "什么都没说呢~")
            return
        }
        
        Router.updateAutograph(string: autograph).request { (status, json) in
            
            self.updateUser(status, json: json)
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - private method
    
    fileprivate func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background

        let rightBarButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(rightBarItem(tap:)))
        navigationItem.rightBarButtonItem = rightBarButton
        
        autographTextField.delegate = self
        if !autographTextField.isFirstResponder{
            autographTextField.becomeFirstResponder()
        }
        
        if !autograph.isEmpty{
            autographTextField.text = autograph
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
        
        containerView.addSubview(autographTextField)
        autographTextField.snp.makeConstraints { (make) in
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
    fileprivate let autographTextField:UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.mo_font()
        textfield.textColor = UIColor.mo_lightBlack
        textfield.placeholder = "说点什么吧~"
        return textfield
    }()
    
    fileprivate let promptLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font(.smaller)
        label.text = ""
        return label
    }()
    
    var autograph:String = ""
}

extension AutoGraphController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > 40{
            textField.text = text.substring(to: 40)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.replacingCharacters(in: range, with: string)
        if toBeString.characters.count > 40{
            textField.text = (toBeString as NSString).substring(to: 40)
            return false
        }
        return true
    }
}
