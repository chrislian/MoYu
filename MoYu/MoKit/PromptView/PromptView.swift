//
//  PromptView.swift
//  MoYu
//
//  Created by Chris on 16/8/27.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Spring


enum PromptViewType {
    case input//输入
    case notify//提示
    case choose//选择
}

class PromptView: SpringView {

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type:PromptViewType) {
        self.init(frame: CGRect.zero)
        
        self.setupView(type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - private method
    fileprivate func setupView(_ type:PromptViewType){
        
        self.backgroundColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0 )
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(40)
        }
        
        self.addSubview(separateLine)
        separateLine.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(1.0)
        }
        
        let view1 = UIView()
        self.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(36)
            make.top.equalTo(separateLine.snp.bottom).offset(5)
        }
        layout(view1: view1, type: type)
        
        let view2 = UIView()
        self.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(view1.snp.bottom).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(40)
        }
        layout(view2: view2, type: type)
    }
    
    
    func layout(view1 view:UIView, type:PromptViewType){
        if type == .input{
            view.addSubview(textfield)
            textfield.snp.makeConstraints({ (make) in
                make.edges.equalTo(view)
            })
        }else{
            view.addSubview(subTitleLabel)
            subTitleLabel.snp.makeConstraints({ (make) in
                make.edges.equalTo(view)
            })
        }
    }
    
    func layout(view2 view:UIView, type:PromptViewType){
        
        if type == .notify{
            view.addSubview(confirmButton)
            confirmButton.snp.makeConstraints({ (make) in
                make.edges.equalTo(view)
            })

        }else{
            view.addSubview(confirmButton)
            view.addSubview(cancelButton)
            
            cancelButton.snp.makeConstraints({ (make) in
                make.left.top.bottom.equalTo(view)
            })
            confirmButton.snp.makeConstraints({ (make) in
                make.right.top.bottom.equalTo(view)
                make.left.equalTo(cancelButton.snp.right).offset(10)
                make.width.equalTo(cancelButton)
            })
        }
    }
    
    
    //MARK: - var & let
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_main
        label.font = UIFont.mo_font(.bigger)
        label.text = "温馨提示"
        return label
    }()
    
    fileprivate let separateLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mo_silver
        return view
    }()
    
    fileprivate let subTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font()
        return label
    }()
    
    let textfield:UITextField = {
        let text = UITextField()
        text.font = UIFont.mo_font()
        text.textColor = UIColor.mo_lightBlack
        text.placeholder = "在此输入内容"
        text.borderStyle = .none
        text.clearButtonMode = .whileEditing
        return text
    }()
    
    let cancelButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.mo_font(.bigger)
        button.backgroundColor = UIColor.mo_silver
        button.setTitle("取消", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    let confirmButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.mo_font(.bigger)
        button.backgroundColor = UIColor.mo_main
        button.setTitle("确定", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
}
