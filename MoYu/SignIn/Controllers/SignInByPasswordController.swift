//
//  SignInByPasswordController.swift
//  MoYu
//
//  Created by Chris on 16/7/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

private enum TextFieldType:Int{

    case Username = 1
    case Password
    
    func maxLength()->Int{
        switch self {
        case .Username:
            return 11
        case .Password:
            return 25
        }
    }
    
    func minLength()->Int{
        switch self {
        case .Username:
            return 11
        case .Password:
            return 6
        }
    }
}

class SignInByPasswordController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationBarOpaque = false
    }
    
    //MARK: - event reponse
    func enterButtonClicked(sender:UIButton){
        
        guard let username = signInView.userTextfield.text,
            let passowrd = signInView.passwordTextFiled.text else{
                println("手机或密码不能为空")
                return
        }
    }
    
    
    //MARK: - private method
    private func setupView(){
        
        signInView.userTextfield.delegate = self
        signInView.userTextfield.tag = TextFieldType.Username.rawValue
        
        signInView.passwordTextFiled.delegate = self
        signInView.passwordTextFiled.tag = TextFieldType.Password.rawValue
    }
    
    
    @IBOutlet var signInView: SignInByPasswordView!
}

extension SignInByPasswordController:UITextFieldDelegate{

    func textFieldDidEndEditing(textField: UITextField) {
        //
        print("end editing")
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
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
