//
//  PostPartimeJobDetailController.swift
//  MoYu
//
//  Created by 连晓彬 on 16/8/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText

class PostPartimeJobDetailController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布兼职"
    
        self.layout()
        self.setupView()
    }
    
    //MARK: - event reponse
    dynamic private func submitButtonClicked(sender:UIButton){
        println("提交兼职")
    }
    
    //MARK: - private method
    
    private func setupView(){
        

    }
    
    private func layout(){
        self.view.backgroundColor = UIColor.mo_background()
        
        self.view.addSubview(titleText)
        titleText.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(10)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(contentText)
        contentText.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(titleText.snp_bottom).offset(10)
        }
        
        self.view.addSubview(countDownLabel)
        countDownLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(contentText.snp_bottom).offset(5)
        }
        
        self.view.addSubview(submitButton)
        submitButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-10)
            make.top.equalTo(countDownLabel.snp_bottom).offset(10)
            make.height.equalTo(50)
        }
    }

    
    //MARK: - var & let
    private lazy var titleText:YYTextView = {
        let text = YYTextView()
        text.backgroundColor = UIColor.whiteColor()
        text.placeholderFont = UIFont.mo_font()
        text.placeholderTextColor = UIColor.lightGrayColor()
        text.placeholderText = "请输入标题"
        text.textColor = UIColor.mo_lightBlack()
        text.font = UIFont.mo_font()
        text.delegate = self
        return text
    }()
    
    private lazy var contentText:YYTextView = {
        let text = YYTextView()
        text.backgroundColor = UIColor.whiteColor()
        text.placeholderFont = UIFont.mo_font()
        text.placeholderTextColor = UIColor.lightGrayColor()
        text.placeholderText = "请输入详细步骤"
        text.textColor = UIColor.mo_lightBlack()
        text.font = UIFont.mo_font()
        text.delegate = self
        return text
    }()
    
    private lazy var countDownLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.mo_font(.smaller)
        label.text = "0/500"
        return label
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.mo_main()
        button.setTitle("确认", forState: .Normal)
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font(.big)
        button.addTarget(self, action: #selector(submitButtonClicked(_:)), forControlEvents: .TouchUpInside)
        button.layer.borderColor = UIColor.mo_lightBlack().CGColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
}

extension PostPartimeJobDetailController: YYTextViewDelegate{
    
    
    func textView(textView: YYTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        func handleContentView()-> Bool {
            let maxLength = 500
            let string = (textView.text)! as NSString
            let toBeString = string.stringByReplacingCharactersInRange(range, withString: text)
            
            countDownLabel.text = "\(toBeString.length)/\(maxLength)"
            
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substringToIndex(maxLength)
                self.showMessage(title: "内容超过上限了~")
                return false
            }
            return true
        }
        
        func handleTitleView()->Bool{
            let maxLength = 40
            let string = (textView.text)! as NSString
            let toBeString = string.stringByReplacingCharactersInRange(range, withString: text)
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substringToIndex(maxLength)
                self.showMessage(title: "内容超过上限了~")
                return false
            }
            return true
        }
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        if textView === self.titleText{
            return handleTitleView()
        }else{
            return handleContentView()
        }
    }
}
