//
//  RecommendController.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class RecommendController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "推荐有奖")
        
        navigationItem.leftBarButtonItems = leftBarButtonItems
        
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
    
    dynamic private func rightBarItem(tap sender:AnyObject){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func backButton(tap sender:AnyObject){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - private method
    func setupView(){

        let rightBarButton = UIBarButtonItem(title: "分享", style: .Plain, target: self, action: #selector(rightBarItem(tap:)))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    //MARK: - var & let
    @IBOutlet var recommendView: RecommendView!
    
    private lazy var leftBarButtonItems:[UIBarButtonItem] = {
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil , action: nil)
        spaceItem.width = 1//-16
        let barButton = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .Done, target: self, action: #selector(MessageCenterController.backButton(tap:)))
        return [spaceItem, barButton]
    }()
}
