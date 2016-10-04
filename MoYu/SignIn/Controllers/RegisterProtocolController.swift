//
//  RegisterProtocolController.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class RegisterProtocolController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "注册协议")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       navigationController?.mo_navigationBar(opaque: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       navigationController?.mo_navigationBar(opaque: false)
    }
}
