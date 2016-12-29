//
//  RecuritCenterController.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class RecuritCenterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        mo_rootLeftBackButton()
        
        mo_navigationBar(title: "招募中心")
        
        bannerImageView.clipsToBounds = true
    }

    //MARK: - event response
    func backButton(tap sender:AnyObject){
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background
        vc.title = "招募详情"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - var & let
    @IBOutlet weak var bannerImageView: UIImageView!
}
