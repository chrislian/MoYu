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

class SignInByAuthController: UIViewController,PraseErrorType,AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        navigationController?.mo_hideBackButtonTitle()
        navigationController?.mo_navigationBar(opaque: false)
        
    }
    
    deinit{
        countDownTimer?.invalidate()
    }
    
    
    //MARK: - event reponse
    func enterButtonTap(_ sender: UIButton){
        
        self.view.endEditing(true)
        
        guard let phoneNum = signInView.userTextfield.text,
            let authCode = signInView.authTextFiled.text , enterButtonCheck() else{
                return
        }
        
        Router.signIn(phone: phoneNum, verifyCode: authCode).request {[weak self] (status, json) in
            if case .success = status,
                let data = json{
                
                UserManager.sharedInstance.update(user: data, phone: phoneNum)
                self?.autoSignInEMC(username: phoneNum, password: "123456")
                
                self?.dismissSignInView()
            }else{
                self?.show(error: status)
            }
        }
    }
    
    func authButtonTap(_ sender:UIButton){
        
        guard let phoneNum = signInView.userTextfield.text , checkValidatePhone(signInView.userTextfield) else{
            return
        }
        
        self.lockCurrent(button: signInView.authButton, waitSectionds: 60)
        
        Router.authCode(phone: phoneNum).request { (status, json) in
            self.show(error: status, showSuccess: true)
        }
    }
    
    func close(tap sender:AnyObject){
        
        self.dismiss(animated: true, completion: nil)
    }
    

    //MARK: - private method
    
    private func autoSignInEMC(username:String,password:String){
        
        if !EMClient.shared().isLoggedIn {
            EMClient.shared().login(withUsername: username, password: password, completion: { (aUsername, error) in
                
                if error == nil{
                    EMClient.shared().options.isAutoLogin = true
                }
                
                println("login EMClient success")
            })
        }
    }
    

    fileprivate func setupView(){
        
        mo_rootLeftBackButton(image: UIImage(named: "nav_close"))
        
        signInView.enterButton.addTarget(self, action: #selector(enterButtonTap(_:)), for: .touchUpInside)
        signInView.authButton.addTarget(self, action: #selector(authButtonTap(_:)),for: .touchUpInside)
        
        signInView.userTextfield.delegate = self
        signInView.authTextFiled.delegate = self
        
        signInView.userTextfield.keyboardType = .numberPad
        signInView.authTextFiled.keyboardType = .numberPad
        
        signInView.userTextfield.tag = TextFieldType.phoneNum.rawValue
        signInView.authTextFiled.tag = TextFieldType.authCode.rawValue
    }
    
    fileprivate func enterButtonCheck()->Bool{
        
        if !checkValidatePhone(signInView.userTextfield){
            return false
        }
        
        guard let text = signInView.authTextFiled.text , text.mo_length() == 6 else{
            self.showAlert(message: "验证码长度不正确")
            return false
        }
        return true
    }
    
    fileprivate func checkValidatePhone(_ textFiled: UITextField)->Bool{
        
        guard let text = textFiled.text else{
            self.showAlert(message: "手机号码不能为空")
            return false
        }
        
        if text.mo_length() != 11 || !IdentifyCode.validatePhone(phone: text){
            self.showAlert(message: "手机号码格式不正确")
            return false
        }
        
        return true
    }
    

    //MARK: - var & let
    @IBOutlet var signInView: SignInByAuthView!
    
    fileprivate var countDownTime = 60
    fileprivate var countDownLabel :UILabel = {
        let label = UILabel()
        
        label.backgroundColor = UIColor.mo_lightYellow
        label.font = UIFont.mo_font(.smallest)
        label.textAlignment = .center
        label.text = "60s重新获取"
        label.textColor = UIColor.mo_silver
        
        return label
    }()
    
    fileprivate var countDownButton:UIButton?
    fileprivate var countDownTimer:Timer?
}

extension SignInByAuthController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        func handleInputTextField(_ maxLength: Int) {
            let text = (textField.text)! as NSString
            if text.length > maxLength{
                textField.text = text.substring(to: maxLength)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        func handleInputTextField(_ maxLength: Int)-> Bool {
            let text = (textField.text)! as NSString
            let toBeString = text.replacingCharacters(in: range, with: string)
            if toBeString.characters.count > maxLength{
                textField.text = (toBeString as NSString).substring(to: maxLength)
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
            
            countDownButton?.isEnabled = true
            countDownLabel.removeFromSuperview()
            countDownTimer?.invalidate()
        }
    }
    
    func lockCurrent(button:UIButton, waitSectionds:Int){
        
        countDownTimer?.invalidate()
        
        countDownTime = waitSectionds
        
        countDownLabel.text = "\(countDownTime)s重新获取"
        
        button.isEnabled = false
        countDownButton = button
        countDownButton?.addSubview(countDownLabel)
        
        countDownLabel.frame = button.bounds
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountDownLabel), userInfo: nil, repeats: true)
    }
}


