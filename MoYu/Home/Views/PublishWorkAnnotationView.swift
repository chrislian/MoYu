//
//  PublishWorkAnnotationView.swift
//  MoYu
//
//  Created by lxb on 2016/12/2.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PublishWorkAnnotationView: BMKAnnotationView {

    
    //MARK: - life cycle
    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.bounds = CGRect(x: 0, y: 0, width: 60, height: 64)
        self.backgroundColor = UIColor.clear
        
//        setupView()
        self.addSubview(annotationImageView)
        annotationImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - var & let
    private let annotationImageView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "avatarActiveBg")
        return imageView
    }()
}
