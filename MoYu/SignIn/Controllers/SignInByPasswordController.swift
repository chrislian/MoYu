//
//  SignInByPasswordController.swift
//  MoYu
//
//  Created by Chris on 16/7/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

private enum TextFieldType:Int{

    case username = 1
    case password
    
    func maxLength()->Int{
        switch self {
        case .username:
            return 11
        case .password:
            return 25
        }
    }
    
    func minLength()->Int{
        switch self {
        case .username:
            return 11
        case .password:
            return 6
        }
    }
}

class SignInByPasswordController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.mo_navigationBar(opaque: false)
    }

    //MARK: - event reponse
    func enterButtonClicked(_ sender:UIButton){
        
        guard let username = signInView.userTextfield.text , !username.isEmpty,
            let password = signInView.passwordTextFiled.text , !password.isEmpty else{
                println("手机或密码不能为空")
                return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - private method
    fileprivate func setupView(){
        
        signInView.userTextfield.delegate = self
        signInView.userTextfield.tag = TextFieldType.username.rawValue
        
        signInView.passwordTextFiled.delegate = self
        signInView.passwordTextFiled.tag = TextFieldType.password.rawValue
        
        signInView.enterButton.addTarget(self, action: #selector(enterButtonClicked), for: .touchUpInside)
    }
    
    
    @IBOutlet var signInView: SignInByPasswordView!
}

extension SignInByPasswordController:UITextFieldDelegate{

    func textFieldDidEndEditing(_ textField: UITextField) {
        //
        print("end editing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let type = TextFieldType(rawValue: textField.tag) else{  return true }
        
        var text:String
        if let str = textField.text {
            text = str + string
        }else{
            text = string
        }
        
        if text.mo_length() <= type.maxLength(){
            return true
        }else{
            return false
        }
    }
}
