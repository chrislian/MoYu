//
//  HotSearchMenuCell.swift
//  MoYu
//
//  Created by Chris on 16/8/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HotSearchMenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.layout()
    }
    
    // MARK: - private method
    fileprivate func layout(){
//        self.backgroundColor = UIColor.redColor()
        self.addSubview(imageView)
//        imageView.backgroundColor = UIColor.blueColor()
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(53)
        }
        
        self.addSubview(textLabel)
//        textLabel.backgroundColor = UIColor.orangeColor()
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.mo_lightBlack()
        textLabel.font = UIFont.mo_font(.smallest)
        textLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.height.equalTo(15)
            make.bottom.equalTo(self).offset(-10)
            
        }
    }
    
    // MARK: - var & let
    
    lazy var imageView :UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var textLabel = UILabel()
}
