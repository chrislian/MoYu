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
    dynamic private func left(tap sender:AnyObject){
        tapClourse?(.left)
    }
    
    dynamic private func middle(tap sender:AnyObject){
        tapClourse?(.middle)
    }
    
    dynamic private func right(tap sender:AnyObject){
        tapClourse?(.right)
    }
    
    //MARK: - public method
    func update(type type:TopTitleType){
        
        bottomLine.snp_remakeConstraints { (make) in
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
    private func setupView(type:TopTitleType){
        
        addSubview(bottomLine)
        bottomLine.snp_makeConstraints { (make) in
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
        leftLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.bottom.equalTo(bottomLine.snp_top)
        }
        
        addSubview(middleLabel)
        middleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(leftLabel.snp_right)
            make.size.equalTo(leftLabel)
        }
        
        addSubview(rightLabel)
        rightLabel.snp_makeConstraints { (make) in
            make.top.right.equalTo(self)
            make.size.equalTo(middleLabel)
            make.left.equalTo(middleLabel.snp_right)
        }
    }
    
    //MARK: - var & let 
    private lazy var leftLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .Center
        label.text = "兼职"
        label.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(TopTitleView.left(tap:)))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private lazy var middleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .Center
        label.text = "任务"
        label.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(TopTitleView.middle(tap:)))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private lazy var rightLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .Center
        label.text = "积分购"
        label.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(TopTitleView.right(tap:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    private lazy var bottomLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mo_lightBlack()
        return view
    }()
    
    var tapClourse:(TopTitleType -> Void)?
}
