//
//  PublishMessageController.swift
//  MoYu
//
//  Created by Chris on 16/4/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText

class PublishMessageController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发布消息"
        setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if textView.isFirstResponder(){
            textView.resignFirstResponder()
        }
    }
    
    //MARK: 
    func rightBarButtonClicked(){
        
        self.view.endEditing( true )
        
        let text = textView.text
        if text.length == 0{
            self.show(message: "内容不能为空")
            return
        }
        Router.commitJobZone(message: text).request { (status, json) in
            
            self.show(error: status)
            if case .success = status {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_lightYellow()
        self.view.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            let edge = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            make.edges.equalTo(textView.superview!).inset(edge)
        }

        self.addRightNavigationButton(title: "提交")
        self.rightButtonClourse = { [unowned self] in
            self.rightBarButtonClicked()
        }
    }
    
    //MARK: - var & let
    lazy var textView:YYTextView = {
        let textView = YYTextView()
        textView.placeholderText = "来爆料一下兼职过程中的新鲜事情吧..."
        textView.placeholderFont = UIFont.mo_font()
        textView.placeholderTextColor = UIColor.lightGrayColor()
        textView.font = UIFont.mo_font()
        textView.textColor = UIColor.darkGrayColor()
        textView.delegate = self
        return textView
    }()
    
}

//MARK: - YYTextView Delegate
extension PublishMessageController:YYTextViewDelegate{
    
}
