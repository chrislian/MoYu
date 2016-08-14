//
//  SignInController.swift
//  MoYu
//
//  Created by Chris on 16/7/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

private enum TextFieldType:Int{
    case phoneNum = 0,authCode
}

class SignInByAuthController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
        self.addBackNavigationButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationBarOpaque = false
    }
    
    deinit{
        countDownTimer?.invalidate()
    }
    
    
    //MARK: - event reponse
    func enterButtonTap(sender: UIButton){
        
        self.view.endEditing(true)
        
        guard let phoneNum = signInView.userTextfield.text,
            let authCode = signInView.authTextFiled.text where enterButtonCheck() else{
                return
        }
        
        Router.signIn(phone: phoneNum, verifyCode: authCode).request { (status, json) in
            if case .success = status,
                let data = json{
                
                UserManager.sharedInstance.update(user: data, phone: phoneNum)
                println("userJson:\(json)")
                self.dismissSignInView()
            }else{
                self.show(error: status)
            }
        }
    }
    
    func authButtonTap(sender:UIButton){
        
        guard let phoneNum = signInView.userTextfield.text where checkValidatePhone(signInView.userTextfield) else{
            return
        }
        
        self.lockCurrent(button: signInView.authButton, waitSectionds: 60)
        
        Router.authCode(phone: phoneNum).request { (status, json) in
            self.show(error: status, showSuccess: true)
        }
    }
    

    //MARK: - private method

    private func setupView(){
        
        signInView.enterButton.addTarget(self, action: #selector(enterButtonTap(_:)), forControlEvents: .TouchUpInside)
        signInView.authButton.addTarget(self, action: #selector(authButtonTap(_:)),forControlEvents: .TouchUpInside)
        
        signInView.userTextfield.delegate = self
        signInView.authTextFiled.delegate = self
        
        signInView.userTextfield.keyboardType = .NumberPad
        signInView.authTextFiled.keyboardType = .NumberPad
        
        signInView.userTextfield.tag = TextFieldType.phoneNum.rawValue
        signInView.authTextFiled.tag = TextFieldType.authCode.rawValue
    }
    
    private func enterButtonCheck()->Bool{
        
        if !checkValidatePhone(signInView.userTextfield){
            return false
        }
        
        guard let text = signInView.authTextFiled.text where text.mo_length() == 6 else{
            self.show(message: "验证码长度不正确")
            return false
        }
        return true
    }
    
    private func checkValidatePhone(textFiled: UITextField)->Bool{
        
        guard let text = textFiled.text else{
            self.show(message: "手机号码不能为空")
            return false
        }
        
        if text.mo_length() != 11 || !IdentifyCode.validatePhone(phone: text){
            self.show(message: "手机号码格式不正确")
            return false
        }
        
        return true
    }
    

    //MARK: - var & let
    @IBOutlet var signInView: SignInByAuthView!
    
    private var countDownTime = 60
    private var countDownLabel :UILabel = {
        let label = UILabel()
        
        label.backgroundColor = UIColor.mo_lightYellow()
        label.font = UIFont.mo_font(.smallest)
        label.textAlignment = .Center
        label.text = "60s重新获取"
        label.textColor = UIColor.mo_silver()
        
        return label
    }()
    
    private var countDownButton:UIButton?
    private var countDownTimer:NSTimer?
    
}

extension SignInByAuthController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        func handleInputTextField(maxLength: Int) {
            let text = (textField.text)! as NSString
            if text.length > maxLength{
                textField.text = text.substringToIndex(maxLength)
            }
        }
        
        guard let type = TextFieldType(rawValue: textField.tag) else {
            return
        }
        
        switch type {
        case .phoneNum:
            handleInputTextField(11)
        case .authCode:
            handleInputTextField(6)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        func handleInputTextField(maxLength: Int)-> Bool {
            let text = (textField.text)! as NSString
            let toBeString = text.stringByReplacingCharactersInRange(range, withString: string)
            if toBeString.characters.count > maxLength{
                textField.text = (toBeString as NSString).substringToIndex(maxLength)
                return false
            }
            return true
        }
        
        guard let type = TextFieldType(rawValue: textField.tag) else {
            return true
        }
        
        switch type {
        case .phoneNum:
            return handleInputTextField(11)
        case .authCode:
            return handleInputTextField(6)
        }
    }
}


extension SignInByAuthController{
    
    func updateCountDownLabel(){
        countDownTime -= 1
        countDownLabel.text = "\(countDownTime)s重新获取"
        
        if countDownTime <= 0{
            
            countDownButton?.enabled = true
            countDownLabel.removeFromSuperview()
            countDownTimer?.invalidate()
        }
    }
    
    func lockCurrent(button button:UIButton, waitSectionds:Int){
        
        countDownTimer?.invalidate()
        
        countDownTime = waitSectionds
        
        countDownLabel.text = "\(countDownTime)s重新获取"
        
        button.enabled = false
        countDownButton = button
        countDownButton?.addSubview(countDownLabel)
        
        countDownLabel.frame = button.bounds
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateCountDownLabel), userInfo: nil, repeats: true)
    }
}


