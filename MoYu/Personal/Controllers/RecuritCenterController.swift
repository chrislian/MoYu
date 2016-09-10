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

        self.title = "招募中心"
        
        navigationItem.leftBarButtonItems = leftBarButtonItems
        
        bannerImageView.clipsToBounds = true
    }

    //MARK: - event response
    func backButton(tap sender:AnyObject){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        vc.title = "招募详情"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - var & let
    @IBOutlet weak var bannerImageView: UIImageView!
    
    private lazy var leftBarButtonItems:[UIBarButtonItem] = {
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil , action: nil)
        spaceItem.width = 1//-16
        let barButton = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .Done, target: self, action: #selector(MessageCenterController.backButton(tap:)))
        return [spaceItem, barButton]
    }()
}
