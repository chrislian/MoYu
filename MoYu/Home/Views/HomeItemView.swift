//
//  HomeItemView.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SnapKit


enum MOHomeItemType {
    case GPS,Menu,Search
}

class HomeItemView: UIView {

    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - event response
    @objc private func tapGesture1Clicked(sender:UITapGestureRecognizer){
        guard let closure = homeItemClosure else{
            return
        }
        closure(type: .GPS)
    }
    @objc private func tapGesture2Clicked(sender:UITapGestureRecognizer){
        guard let closure = homeItemClosure else{
            return
        }
        closure(type: .Menu)
    }
    @objc private func tapGesture3Clicked(sender:UITapGestureRecognizer){
        guard let closure = homeItemClosure else{
            return
        }
        closure(type: .Search)
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.backgroundColor = UIColor.clearColor()
        
        self.addSubview(gpsImageView)
        gpsImageView.snp_makeConstraints { (make) in
            make.top.equalTo(gpsImageView.superview!)
            make.centerX.equalTo(gpsImageView.superview!)
            make.height.width.equalTo(50)
        }
        
        self.addSubview(menuImageView)
        menuImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(menuImageView.superview!)
            make.top.equalTo(gpsImageView.snp_bottom).offset(8)
            make.width.height.equalTo(gpsImageView)
        }
        
        self.addSubview(searchImageView)
        searchImageView.snp_makeConstraints { (make) in
            make.bottom.lessThanOrEqualTo(searchImageView.superview!)
            make.centerX.equalTo(searchImageView.superview!)
            make.top.equalTo(menuImageView.snp_bottom).offset(8)
            make.width.height.equalTo(gpsImageView)
        }
    }
    
    
    //MARK: - var & let 
    lazy private var gpsImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "home_GPS")
        imageView.backgroundColor = UIColor.clearColor()
        imageView.userInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture1Clicked(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy private var menuImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "home_menu")
        imageView.backgroundColor = UIColor.clearColor()
        imageView.userInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture2Clicked(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy private var searchImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "home_search")
        imageView.backgroundColor = UIColor.clearColor()
        imageView.userInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture3Clicked(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    var homeItemClosure:((type:MOHomeItemType)->Void)?
}
