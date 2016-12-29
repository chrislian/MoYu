//
//  PostPartimeJobDetailController.swift
//  MoYu
//
//  Created by 连晓彬 on 16/8/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText

class PostPartimeJobDetailController: UIViewController,PraseErrorType, AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mo_navigationBar(title: "发布兼职")
        
        self.layout()
        self.setupView()
    }
    
    //MARK: - event reponse
    dynamic fileprivate func submitButtonClicked(_ sender:UIButton){
        
        if titleText.text.length == 0{
            self.showAlert(message: "标题不能为空")
            return
        }
        
        if contentText.text.length == 0{
            self.showAlert(message: "内容不能为空")
            return
        }
        
        self.postModel.name = titleText.text
        self.postModel.content = contentText.text
    
        Router.postParttimeJob(parameter: self.postModel.combination() ).request { (status, json) in
            self.show(error: status, showSuccess: true)
            
            if case .success = status{
                let _ = self.navigationController?.popToRootViewController( animated: true )
            }
        }
    }
    
    //MARK: - private method
    
    fileprivate func setupView(){
        

    }
    
    fileprivate func layout(){
        self.view.backgroundColor = UIColor.mo_background
        
        self.view.addSubview(titleText)
        titleText.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(10)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(contentText)
        contentText.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(titleText.snp.bottom).offset(10)
        }
        
        self.view.addSubview(countDownLabel)
        countDownLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(contentText.snp.bottom).offset(5)
        }
        
        self.view.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-10)
            make.top.equalTo(countDownLabel.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
    }

    
    //MARK: - var & let
    
    var postModel = PostPartTimeJobModel()
    
    fileprivate lazy var titleText:YYTextView = {
        let text = YYTextView()
        text.backgroundColor = UIColor.white
        text.placeholderFont = UIFont.mo_font()
        text.placeholderTextColor = UIColor.lightGray
        text.placeholderText = "请输入标题"
        text.textColor = UIColor.mo_lightBlack
        text.font = UIFont.mo_font()
        text.delegate = self
        return text
    }()
    
    fileprivate lazy var contentText:YYTextView = {
        let text = YYTextView()
        text.backgroundColor = UIColor.white
        text.placeholderFont = UIFont.mo_font()
        text.placeholderTextColor = UIColor.lightGray
        text.placeholderText = "请输入详细步骤"
        text.textColor = UIColor.mo_lightBlack
        text.font = UIFont.mo_font()
        text.delegate = self
        return text
    }()
    
    fileprivate lazy var countDownLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.mo_font(.smaller)
        label.text = "0/500"
        return label
    }()
    
    fileprivate lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.mo_main
        button.setTitle("发布", for: UIControlState())
        button.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
        button.titleLabel?.font = UIFont.mo_font(.big)
        button.addTarget(self, action: #selector(submitButtonClicked(_:)), for: .touchUpInside)
        button.layer.borderColor = UIColor.mo_lightBlack.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
}

extension PostPartimeJobDetailController: YYTextViewDelegate{
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        func handleContentView()-> Bool {
            let maxLength = 500
            let string = (textView.text)! as NSString
            let toBeString = string.replacingCharacters(in: range, with: text)
            
            countDownLabel.text = "\(toBeString.length)/\(maxLength)"
            
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substring(to: maxLength)
                self.showAlert(message: "内容超过上限了")
                return false
            }
            return true
        }
        
        func handleTitleView()->Bool{
            let maxLength = 40
            let string = (textView.text)! as NSString
            let toBeString = string.replacingCharacters(in: range, with: text)
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substring(to: maxLength)
                self.showAlert(message: "内容超过上限了~")
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
