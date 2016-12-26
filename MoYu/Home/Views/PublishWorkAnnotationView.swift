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
        
        self.bounds = CGRect(x: 0, y: 0, width: 29, height: 37)
        self.backgroundColor = UIColor.clear

        self.addSubview(annotationImageView)
        annotationImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        annotationImageView.layer.anchorPoint = CGPoint(x: 0.2, y: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - var & let
    private let annotationImageView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "home_pin_location")
        return imageView
    }()
}
