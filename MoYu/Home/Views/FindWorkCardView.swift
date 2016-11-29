//
//  FindWorkCardView.swift
//  MoYu
//
//  Created by lxb on 2016/11/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Spring

class FindWorkCardView: SpringView {

    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
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
    
    //MARK: - private methods
    func dismiss(_ duration:TimeInterval = 0.7){
        
        if isVisable{
            self.animation = "fadeOut"
            self.curve = "easeIn"
            self.duration = CGFloat(duration)
            self.animate()
        }
        
        isVisable = false
    }
    
    //MARK: - var & let
    private(set) var isVisable = true
}
