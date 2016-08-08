//
//  RecuritCenterController.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class RecuritCenterController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "招募中心"
        
        self.addBackNavigationButton()
        
        bannerImageView.clipsToBounds = true
    }

    
    
    @IBAction func buttonClicked(sender: UIButton) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        vc.title = "招募详情"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var bannerImageView: UIImageView!
}
