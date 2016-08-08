//
//  RecommendController.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class RecommendController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "推荐有奖"
        
        self.addBackNavigationButton()
        
        self.setupView()
    }
    
    //MARK: - event response
    @IBAction func inviteFriendTap(sender: AnyObject) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moreRecommendTap(sender: UIButton) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    dynamic private func leftBarItemTap(){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - private method
    func setupView(){

        self.addRightNavigationButton(title: "分享")
        self.rightButtonClourse = { [unowned  self] in
            self.leftBarItemTap()
        }
    }
    
    //MARK: - var & let
    @IBOutlet var recommendView: RecommendView!
}
