//
//  TopTitleView.swift
//  MoYu
//
//  Created by Chris on 16/9/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


enum TopTitleType:Int{
    
    case left, middle, right
}

class TopTitleView: UIView {
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView(.left)
    }
    
    init(frame: CGRect, type:TopTitleType) {
        
        super.init(frame:frame)
        
        setupView(type)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - event reponse
    dynamic fileprivate func left(tap sender:AnyObject){
        tapClourse?(.left)
    }
    
    dynamic fileprivate func middle(tap sender:AnyObject){
        tapClourse?(.middle)
    }
    
    dynamic fileprivate func right(tap sender:AnyObject){
        tapClourse?(.right)
    }
    
    //MARK: - public method
    func update(type:TopTitleType){
        
        bottomLine.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self)
            make.width.equalTo(leftLabel)
            make.height.equalTo(2)
            switch type{
            case .left:
                make.left.equalTo(self)
            case .middle:
                make.centerX.equalTo(self)
            case .right:
                make.right.equalTo(self)
            }
        }
    }
    
    //MARK: - private method
    fileprivate func setupView(_ type:TopTitleType){
        
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(2)
            switch type{
            case .left:
                make.left.equalTo(self)
            case .middle:
                make.centerX.equalTo(self)
            case .right:
                make.right.equalTo(self)
            }
        }
        
        addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.bottom.equalTo(bottomLine.snp.top)
        }
        
        addSubview(middleLabel)
        middleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(leftLabel.snp.right)
            make.size.equalTo(leftLabel)
        }
        
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.top.right.equalTo(self)
            make.size.equalTo(middleLabel)
            make.left.equalTo(middleLabel.snp.right)
        }
    }
    
    //MARK: - var & let 
    fileprivate lazy var leftLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .center
        label.text = "兼职"
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(TopTitleView.left(tap:)))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    fileprivate lazy var middleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .center
        label.text = "任务"
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(TopTitleView.middle(tap:)))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    fileprivate lazy var rightLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .center
        label.text = "积分购"
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(TopTitleView.right(tap:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    fileprivate lazy var bottomLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mo_lightBlack
        return view
    }()
    
    var tapClourse:((TopTitleType) -> Void)?
}
