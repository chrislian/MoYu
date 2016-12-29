//
//  PublishSheetView.swift
//  MoYu
//
//  Created by Chris on 16/4/16.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SnapKit
import Spring

enum MOPublishSheetMode:Int {
    case partTime = 0,task
}

class PublishSheetView: SpringView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public methods
    func show(){
        if !isVisable{
            self.animation = "slideUp"
            self.curve = "easeIn"
            self.duration = 1
            self.animate()
        }
        isVisable = true
    }
    
    func dismiss(_ duration:TimeInterval = 0.7){
        
        if isVisable{
            self.animation = "fadeOut"
            self.curve = "easeIn"
            self.duration = CGFloat(duration)
            self.animate()
        }
        isVisable = false
    }

    
    //MARK: - private method
    fileprivate func setupView(){
    
        layoutView()
        publishType = .partTime
        
    }
    
    fileprivate func layoutView(){

        let view0:UIView = {
            let view = UIView()
            self.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.left.right.top.equalTo(view.superview!)
                make.height.equalTo(44)
            })
            
            view.addSubview(parttimeJobLine)
            parttimeJobLine.snp.makeConstraints( { (make) in
                make.left.equalTo(view).offset(15)
                make.bottom.equalTo(view)
                make.height.equalTo(3)
            })
            
            view.addSubview(taskJobLine)
            taskJobLine.snp.makeConstraints( { (make) in
                make.right.equalTo(view).offset(-15)
                make.bottom.equalTo(view)
                make.left.equalTo(parttimeJobLine.snp.right).offset(20)
                make.size.equalTo(parttimeJobLine)
            })
            
            view.addSubview(parttimeButton)
            view.addSubview(taskButton)
            parttimeButton.snp.makeConstraints { (make) in
                make.left.top.bottom.equalTo(view)
            }
            taskButton.snp.makeConstraints { (make) in
                make.right.top.bottom.equalTo(view)
                make.left.equalTo(parttimeButton.snp.right)
                make.width.equalTo(parttimeButton)
            }
            return view
        }()
        
        let view1:UIView = {
            let view = UIView()
            self.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.left.right.equalTo(view.superview!)
                make.top.equalTo(view0.snp.bottom)
                make.height.equalTo(view0)
            })
            
            view.addSubview(locationImageView)
            locationImageView.snp.makeConstraints({ (make) in
                make.centerY.equalTo(view)
                make.left.equalTo(view).offset(8)
                make.height.width.equalTo(18)
            })
            
            view.addSubview(locationLabel)
            locationLabel.snp.makeConstraints({ (make) in
                make.centerY.right.equalTo(view)
                make.left.equalTo(locationImageView.snp.right).offset(8)
            })
            
            return view
        }()
        
        let view2:UIView = {
            let view = UIView()
            self.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalTo(view.superview!)
                make.top.equalTo(view1.snp.bottom)
                make.height.equalTo(view1)
            })
            return view
        }()
        view2.addSubview(publishButton)
        publishButton.snp.makeConstraints { (make) in
            make.edges.equalTo(view2)
        }
    }
    
    //MARK: - event response
    @objc fileprivate func buttonClicked(_ sender:UIButton){
        
        publishType = MOPublishSheetMode(rawValue: sender.tag)!
    }
    
    @objc fileprivate func publishButtonClicked(){
        
        publishClosure?(publishType)
    }
    
    
    //MARK: - var & let
    
    private(set) var isVisable = true
    
    var publishClosure:((_ type:MOPublishSheetMode)->Void)?
    
    fileprivate var publishType:MOPublishSheetMode = .partTime{
        didSet{
            switch publishType {
            case .partTime:
                parttimeButton.setTitleColor(UIColor.mo_main, for: UIControlState())
                taskButton.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
                
                UIView.animate(withDuration: 0.3, animations: { 
                        self.parttimeJobLine.backgroundColor = UIColor.mo_main
                        self.taskJobLine.backgroundColor = UIColor.clear
                    }, completion: {_ in
                        self.parttimeJobLine.backgroundColor = UIColor.mo_main
                        self.taskJobLine.backgroundColor = UIColor.clear
                })
            case .task:
                
                parttimeButton.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
                taskButton.setTitleColor(UIColor.mo_main, for: UIControlState())
                UIView.animate(withDuration: 0.3, animations: { 
                        self.parttimeJobLine.backgroundColor = UIColor.clear
                        self.taskJobLine.backgroundColor = UIColor.mo_main
                    }, completion: { _ in
                        self.parttimeJobLine.backgroundColor = UIColor.clear
                        self.taskJobLine.backgroundColor = UIColor.mo_main
                })
            }
        }
    }
    
    fileprivate lazy var parttimeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = MOPublishSheetMode.partTime.rawValue
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        button.setTitle("发兼职", for: UIControlState())
        button.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
        button.titleLabel?.font = UIFont.mo_font()
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    fileprivate lazy var taskButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = MOPublishSheetMode.task.rawValue
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        button.setTitle("发任务", for: UIControlState())
        button.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
        button.titleLabel?.font = UIFont.mo_font()
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    fileprivate let locationImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "home_address_icon")
        return imageView
    }()
    
    let locationLabel:UILabel = {
        let  label = UILabel()
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font()
        label.text = "当前位置"
        return label
    }()
    
    fileprivate lazy var publishButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
        button.setTitle("完善发布信息", for: UIControlState())
        button.titleLabel?.font = UIFont.mo_font()
        button.addTarget(self, action: #selector(publishButtonClicked), for: .touchUpInside)
        button.backgroundColor = UIColor.mo_main
        return button
    }()
    
    fileprivate lazy var parttimeJobLine :UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    fileprivate lazy var taskJobLine :UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
}
