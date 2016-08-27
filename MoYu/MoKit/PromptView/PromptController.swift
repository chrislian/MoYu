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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        promptView.animation = "slideUp"
        promptView.animate()
    }
    
    //MARK: - event response
    @objc private func buttonTap(cancel sender:UIButton){
        
        promptView.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func buttonTap(confirm sender:UIButton){
        
        promptView.endEditing(true)
        
        self.confirmClourse?(promptView.textfield.text ?? "")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        promptView.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    //MARK: - private method
    private func setupView(){
        
        self.view.addSubview(promptView)
        promptView.snp_makeConstraints { (make) in
            make.left.equalTo(self.view).offset(12)
            make.right.equalTo(self.view).offset(-12)
            make.centerY.equalTo(self.view).offset(-50)
        }
        
        promptView.textfield.delegate = self
        
        promptView.cancelButton.addTarget(self, action: #selector(buttonTap(cancel:)), forControlEvents: .TouchUpInside)
        
        promptView.confirmButton.addTarget(self, action: #selector(buttonTap(confirm:)), forControlEvents: .TouchUpInside)
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
                        configClourse: (UITextField->Int)? = nil ) -> PromptController{
        
        let vc = PromptController()
        vc.promptView.titleLabel.text = text
        vc.promptView.confirmButton.setTitle(confirm, forState: .Normal)
        if let length = configClourse?(vc.promptView.textfield){
            vc.textMaxLength = length
        }
        return vc
    }
    
    func show(inViewController: UIViewController){
        
        self.modalPresentationStyle = .OverCurrentContext
        inViewController.view.window?.rootViewController?.presentViewController(self, animated: false, completion: { [unowned self] _ in
            self.promptView.textfield.becomeFirstResponder()
        })
    }
    
    //MARK: - var & let
    private let promptView:PromptView = {
        let view = PromptView(type: .input)
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.mo_mercury().CGColor
        view.layer.borderWidth = 0.7
        return view
    }()
    
    var confirmClourse:(String->Void)?
    
    //textfield maxlength
    var textMaxLength = 0
}

extension PromptController: UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > textMaxLength{
            textField.text = text.substringToIndex(textMaxLength)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.stringByReplacingCharactersInRange(range, withString: string)
        if toBeString.characters.count > textMaxLength{
            textField.text = (toBeString as NSString).substringToIndex(textMaxLength)
            return false
        }
        return true
    }
}
