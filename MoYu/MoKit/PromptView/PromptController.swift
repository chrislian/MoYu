//
//  PromptController.swift
//  MoYu
//
//  Created by Chris on 16/8/27.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PromptController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        promptView.animation = "slideUp"
        promptView.animate()
    }
    
    //MARK: - event response
    @objc fileprivate func buttonTap(cancel sender:UIButton){
        
        promptView.endEditing(true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func buttonTap(confirm sender:UIButton){
        
        promptView.endEditing(true)
        
        self.confirmClourse?(promptView.textfield.text ?? "")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        promptView.endEditing(true)
        
        self.dismiss(animated: true, completion: nil)
    }
    

    //MARK: - private method
    fileprivate func setupView(){
        
        self.view.addSubview(promptView)
        promptView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(12)
            make.right.equalTo(self.view).offset(-12)
            make.centerY.equalTo(self.view).offset(-50)
        }
        
        promptView.textfield.delegate = self
        
        promptView.cancelButton.addTarget(self, action: #selector(buttonTap(cancel:)), for: .touchUpInside)
        
        promptView.confirmButton.addTarget(self, action: #selector(buttonTap(confirm:)), for: .touchUpInside)
    }
    

    //MARK: - public method
    /**
     创建对象
     
     - parameter text:           标题
     - parameter confirm:        确认文本信息
     - parameter configClourse:  配置UITextField, 返回最大输入长度
     
     - returns: PromptController
     */
    class func instance(title text: String? = nil,
                        confirm: String? = nil,
                        configClourse: ((UITextField)->Int)? = nil ) -> PromptController{
        
        let vc = PromptController()
        vc.promptView.titleLabel.text = text
        vc.promptView.confirmButton.setTitle(confirm, for: UIControlState())
        if let length = configClourse?(vc.promptView.textfield){
            vc.textMaxLength = length
        }
        return vc
    }
    
    func show(_ inViewController: UIViewController){
        
        self.modalPresentationStyle = .overCurrentContext
        inViewController.view.window?.rootViewController?.present(self, animated: false, completion: { [unowned self] _ in
            self.promptView.textfield.becomeFirstResponder()
        })
    }
    
    //MARK: - var & let
    fileprivate let promptView:PromptView = {
        let view = PromptView(type: .input)
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.mo_mercury.cgColor
        view.layer.borderWidth = 0.7
        return view
    }()
    
    var confirmClourse:((String)->Void)?
    
    //textfield maxlength
    var textMaxLength = 0
}

extension PromptController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > textMaxLength{
            textField.text = text.substring(to: textMaxLength)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.replacingCharacters(in: range, with: string)
        if toBeString.characters.count > textMaxLength{
            textField.text = (toBeString as NSString).substring(to: textMaxLength)
            return false
        }
        return true
    }
}
