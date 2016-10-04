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
        mo_rootLeftBackButton()
        
        self.setupView()
    }
    
    //MARK: - event response
    @IBAction func inviteFriendTap(_ sender: AnyObject) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moreRecommendTap(_ sender: UIButton) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    dynamic fileprivate func rightBarItem(tap sender:AnyObject){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func backButton(tap sender:AnyObject){
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - private method
    func setupView(){

        let rightBarButton = UIBarButtonItem(title: "分享", style: .plain, target: self, action: #selector(rightBarItem(tap:)))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    //MARK: - var & let
    @IBOutlet var recommendView: RecommendView!
}
