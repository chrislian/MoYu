//
//  FeedbackView.swift
//  MoYu
//
//  Created by Chris on 16/8/7.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText

class FeedbackView: UIView {

    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private method    
    private func layout(){
        
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        self.addSubview(view)
        view.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(44)
            make.top.equalTo(self).offset(10)
        }
        
        let label = UILabel()
        label.text = "类型"
        label.textColor = UIColor.mo_lightBlack()
        view.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.centerY.equalTo(view)
            make.width.equalTo(40)
        }
        
        view.addSubview(typeButton)
        typeButton.snp_makeConstraints { (make) in
            make.left.equalTo(label.snp_right).offset(8)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(5)
            make.bottom.equalTo(view).offset(-5)
        }
        
        //title
        self.addSubview(titleText)
        titleText.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(49)
            make.top.equalTo(view.snp_bottom).offset(20)
        }
        
        //content
        self.addSubview(contentText)
        contentText.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(titleText.snp_bottom).offset(20)
            make.height.equalTo(250)
        }
        
        self.addSubview(countDownLabel)
        countDownLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-8)
            make.top.equalTo(contentText.snp_bottom).offset(8)
        }
    }
    
    //MARK: - var & let
    lazy var typeButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.mo_main(), forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font()
        button.setTitle("开 发", forState: .Normal)
        button.layer.borderColor = UIColor.mo_main().CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var titleText:YYTextView = {
        let text = YYTextView()
        text.placeholderFont = UIFont.mo_font()
        text.font = UIFont.mo_font()
        
        text.placeholderTextColor = UIColor.mo_silver()
        text.textColor = UIColor.mo_lightBlack()
        text.backgroundColor = UIColor.whiteColor()
        
        text.placeholderText = "请输入标题"
        
        return text
    }()
    
    lazy var contentText:YYTextView = {
        let text = YYTextView()
        text.placeholderFont = UIFont.mo_font()
        text.font = UIFont.mo_font()
        
        text.placeholderTextColor = UIColor.mo_silver()
        text.textColor = UIColor.mo_lightBlack()
        text.backgroundColor = UIColor.whiteColor()
        
        text.placeholderText = "请输入您的宝贵意见"
    
        return text
    }()
    
    lazy var countDownLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.mo_font(.smaller)
        label.textColor = UIColor.mo_silver()
        label.text = "0/500"
        return label
    }()
}

