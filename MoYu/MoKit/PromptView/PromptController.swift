//
//  PromptController.swift
//  MoYu
//
//  Created by Chris on 16/8/27.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PromptController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(promptView)
        promptView.snp_makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.centerY.equalTo(self.view).offset(-50)
        }
        
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        promptView.animation = "slideUp"
        promptView.animate()
    }

    
    func show(inViewController: UIViewController){
        
        self.modalPresentationStyle = .OverCurrentContext
        inViewController.view.window?.rootViewController?.presentViewController(self, animated: false, completion: nil)
    }
    
    //MARK: - var & let
    let promptView:PromptView = {
        let view = PromptView(type: .input)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.mo_silver().CGColor
        view.layer.borderWidth = 0.8
        return view
    }()
}
