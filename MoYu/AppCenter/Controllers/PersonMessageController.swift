//
//  PersonMessageController.swift
//  MoYu
//
//  Created by Chris on 16/4/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SnapKit

class PersonMessageController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "消息")
        
        setupMessageView()
    }
    
    //MARK: - event response
    func rightBarButtonClicked(_ sender:UIButton){
        
        println("clear message")
    }
    
    //MARK: - private method
    func setupMessageView(){
        
        let backgroundImageView:UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.center.equalTo(imageView.superview!)
                make.height.width.equalTo(200)
            }
            return imageView
        }()
        backgroundImageView.image = UIImage(named: "no_message")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清空", style: .plain, target: self, action: #selector(rightBarButtonClicked(_:)))
    }
    
    //MARK: - var & let
    lazy var rightBarButton:UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        button.setTitle("清空", for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonClicked(_:)), for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()  
}
