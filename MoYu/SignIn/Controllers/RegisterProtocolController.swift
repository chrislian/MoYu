//
//  RegisterProtocolController.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class RegisterProtocolController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigation(title: "注册协议")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationBarOpaque = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationBarOpaque = false
    }
}
