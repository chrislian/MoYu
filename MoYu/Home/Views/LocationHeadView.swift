//
//  LocationHeadView.swift
//  MoYu
//
//  Created by Chris on 16/8/16.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SnapKit

class LocationHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.whiteColor()
        self.setupView()
//        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private method
    private func setupView(){
        let line0 = self.setupLineView()
        let line1 = self.setupLineView()
        
        self.addSubview(line0)
        line0.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(1)
        }
        
        self.addSubview(locationLab)
        locationLab.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(line0.snp_bottom)
        }
    
        self.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(locationLab.snp_bottom)
            make.height.equalTo(line0)
        }
        
        self.addSubview(subTitleLabel)
        subTitleLabel.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(36)
            make.top.equalTo(line1.snp_bottom)
        }
    }
    
    
   private func setupLineView() -> UIView{
        let lineView = UIView()
        lineView.backgroundColor = UIColor.mo_mercury()
        return lineView
    }
    
    //MARK: - var & let
    var locationLab:UILabel = {
        let  label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font()
        label.text = "当前位置：定位中..."
        return label
    }()
    
    private let subTitleLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.mo_background()
        label.text = "    手动选择"
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        return label
    }()
    
}
