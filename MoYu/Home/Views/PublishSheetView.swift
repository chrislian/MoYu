//
//  PublishSheetView.swift
//  MoYu
//
//  Created by Chris on 16/4/16.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SnapKit

enum MOPublishSheetMode:Int {
    case PartTime = 0,Task
}

class PublishSheetView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private method
    private func setupView(){
    
        layoutView()
        publishType = .PartTime
        
    }
    
    private func layoutView(){

        let view0:UIView = {
            let view = UIView()
            self.addSubview(view)
            view.snp_makeConstraints(closure: { (make) in
                make.left.right.top.equalTo(view.superview!)
                make.height.equalTo(44)
            })
            
            view.addSubview(parttimeJobLine)
            parttimeJobLine.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(view).offset(15)
                make.bottom.equalTo(view)
                make.height.equalTo(3)
            })
            
            view.addSubview(taskJobLine)
            taskJobLine.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(view).offset(-15)
                make.bottom.equalTo(view)
                make.left.equalTo(parttimeJobLine.snp_right).offset(20)
                make.size.equalTo(parttimeJobLine)
            })
            
            view.addSubview(parttimeButton)
            view.addSubview(taskButton)
            parttimeButton.snp_makeConstraints { (make) in
                make.left.top.bottom.equalTo(view)
            }
            taskButton.snp_makeConstraints { (make) in
                make.right.top.bottom.equalTo(view)
                make.left.equalTo(parttimeButton.snp_right)
                make.width.equalTo(parttimeButton)
            }
            return view
        }()
        
        let view1:UIView = {
            let view = UIView()
            self.addSubview(view)
            view.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(view.superview!)
                make.top.equalTo(view0.snp_bottom)
                make.height.equalTo(view0)
            })
            
            view.addSubview(locationImageView)
            locationImageView.snp_makeConstraints(closure: { (make) in
                make.centerY.equalTo(view)
                make.left.equalTo(view).offset(8)
                make.height.width.equalTo(18)
            })
            
            view.addSubview(locationLabel)
            locationLabel.snp_makeConstraints(closure: { (make) in
                make.centerY.right.equalTo(view)
                make.left.equalTo(locationImageView.snp_right).offset(8)
            })
            
            return view
        }()
        
        let view2:UIView = {
            let view = UIView()
            self.addSubview(view)
            view.snp_makeConstraints(closure: { (make) in
                make.left.right.bottom.equalTo(view.superview!)
                make.top.equalTo(view1.snp_bottom)
                make.height.equalTo(view1)
            })
            return view
        }()
        view2.addSubview(publishButton)
        publishButton.snp_makeConstraints { (make) in
            make.edges.equalTo(view2)
        }
    }
    
    //MARK: - event response
    @objc private func buttonClicked(sender:UIButton){
        
        publishType = MOPublishSheetMode(rawValue: sender.tag)!
    }
    
    @objc private func publishButtonClicked(){
        
        publishClosure?(type: publishType)
    }
    
    
    //MARK: - var & let
    var publishClosure:((type:MOPublishSheetMode)->Void)?
    
    private var publishType:MOPublishSheetMode = .PartTime{
        didSet{
            switch publishType {
            case .PartTime:
                parttimeButton.setTitleColor(UIColor.mo_main(), forState: .Normal)
                parttimeJobLine.backgroundColor = UIColor.mo_main()
                taskButton.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
                taskJobLine.backgroundColor = UIColor.clearColor()
            case .Task:
                parttimeJobLine.backgroundColor = UIColor.clearColor()
                taskJobLine.backgroundColor = UIColor.mo_main()
                parttimeButton.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
                taskButton.setTitleColor(UIColor.mo_main(), forState: .Normal)
            }
        }
    }
    
    private lazy var parttimeButton:UIButton = {
        let button = UIButton(type: .Custom)
        button.tag = MOPublishSheetMode.PartTime.rawValue
        button.addTarget(self, action: #selector(buttonClicked(_:)), forControlEvents: .TouchUpInside)
        button.setTitle("发兼职", forState: .Normal)
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font()
        button.titleLabel?.textAlignment = .Center
        return button
    }()
    
    private lazy var taskButton:UIButton = {
        let button = UIButton(type: .Custom)
        button.tag = MOPublishSheetMode.Task.rawValue
        button.addTarget(self, action: #selector(buttonClicked(_:)), forControlEvents: .TouchUpInside)
        button.setTitle("发任务", forState: .Normal)
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font()
        button.titleLabel?.textAlignment = .Center
        return button
    }()
    
    private let locationImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "home_address_icon")
        return imageView
    }()
    
    private let locationLabel:UILabel = {
        let  label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font()
        label.text = "当前位置"
        return label
    }()
    
    private lazy var publishButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.setTitle("完善发布信息", forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font()
        button.addTarget(self, action: #selector(publishButtonClicked), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.mo_main()
        return button
    }()
    
    private lazy var parttimeJobLine :UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var taskJobLine :UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
}
