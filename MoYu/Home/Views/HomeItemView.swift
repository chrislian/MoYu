//
//  HomeItemView.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SnapKit
import Spring

enum MOHomeItemType {
    case gps,menu,search
}

class HomeItemView: SpringView {

    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public methods
    func show(){
        if !isVisable{
            self.animation = "slideLeft"
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
    
    //MARK: - event response
    @objc fileprivate func tapGesture1Clicked(_ sender:UITapGestureRecognizer){
        guard let closure = homeItemClosure else{
            return
        }
        closure(.gps)
    }
    @objc fileprivate func tapGesture2Clicked(_ sender:UITapGestureRecognizer){
        guard let closure = homeItemClosure else{
            return
        }
        closure(.menu)
    }
    @objc fileprivate func tapGesture3Clicked(_ sender:UITapGestureRecognizer){
        guard let closure = homeItemClosure else{
            return
        }
        closure(.search)
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(gpsImageView)
        gpsImageView.snp.makeConstraints { (make) in
            make.top.equalTo(gpsImageView.superview!)
            make.centerX.equalTo(gpsImageView.superview!)
            make.height.width.equalTo(50)
        }
        
        self.addSubview(menuImageView)
        menuImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(menuImageView.superview!)
            make.top.equalTo(gpsImageView.snp.bottom).offset(8)
            make.width.height.equalTo(gpsImageView)
        }
        
        self.addSubview(searchImageView)
        searchImageView.snp.makeConstraints { (make) in
            make.bottom.lessThanOrEqualTo(searchImageView.superview!)
            make.centerX.equalTo(searchImageView.superview!)
            make.top.equalTo(menuImageView.snp.bottom).offset(8)
            make.width.height.equalTo(gpsImageView)
        }
    }
    
    
    //MARK: - var & let 
    lazy fileprivate var gpsImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "home_GPS")
        imageView.backgroundColor = UIColor.clear
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture1Clicked(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy fileprivate var menuImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "home_menu")
        imageView.backgroundColor = UIColor.clear
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture2Clicked(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy fileprivate var searchImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "home_search")
        imageView.backgroundColor = UIColor.clear
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture3Clicked(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    var homeItemClosure:((_ type:MOHomeItemType)->Void)?
    
    fileprivate var isVisable = true
}
