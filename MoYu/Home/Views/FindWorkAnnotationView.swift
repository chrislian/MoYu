//
//  FindWorkAnnotationView.swift
//  MoYu
//
//  Created by lxb on 2016/11/28.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class FindWorkAnnotationView: BMKAnnotationView {

    //MARK: - life cycle
    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    
        self.bounds = CGRect(x: 0, y: 0, width: 60, height: 64)
        self.backgroundColor = UIColor.clear
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public method
    func updateSelect(status isSelected:Bool){
        
        if isSelected {
            self.bounds = CGRect(x: 0, y: 0, width: 80, height: 85)
            avatorImageView.snp.updateConstraints{ (make) in
                make.size.equalTo(CGSize(width: 66, height: 66))
            }
            annotationImageView.image = UIImage(named: "avatarActiveBg")
            
            let pointY = (85.0 - 64.0/2.0)/85.0
            self.layer.anchorPoint = CGPoint(x: 0.5, y: pointY)
        }else{
            self.bounds = CGRect(x: 0, y: 0, width: 60, height: 64)
            avatorImageView.snp.updateConstraints{ (make) in
                make.size.equalTo(CGSize(width: 46, height: 46))
            }
            annotationImageView.image = UIImage(named: "avatarBg")
            self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
        self.layoutIfNeeded()
    }
    
    
    //MARK: - private method
    private func setupView(){
        
        self.addSubview(annotationImageView)
        annotationImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        annotationImageView.addSubview(avatorImageView)
        avatorImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 46, height: 46))
            make.centerX.equalTo(annotationImageView)
            make.centerY.equalTo(annotationImageView).offset(-4)
        }
        
    }
    
    
    //MARK: - var & let
    private let annotationImageView:UIImageView = {
    
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "avatarBg")
        return imageView
    }()

    private let avatorImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "defaultAvator")
        return imageView
    }()
}
