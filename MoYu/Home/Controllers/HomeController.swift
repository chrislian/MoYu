//
//  MYHomeViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SnapKit

enum HomeTitleButtonTag:Int {
    case partTime = 0,task,credit
}

enum FindPublishWork:Int {
    
    case FindWork = 100,PublishWork
}


class HomeController: BaseController {

    //MARK: - event response
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHomeView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.mo_hide(hairLine: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.checkSignIn()
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.mo_hide(hairLine: false)
    }

    //MARK: - memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController.childViewControllers.last as? HomeMenuController {
            vc.location = findWorkVc.location
        }
        
    }
    
    //MARK: - event response
    @IBAction func titleButtonClicked(sender: AnyObject) {
        guard let buttonTag = HomeTitleButtonTag(rawValue: sender.tag) else{
//            println("button tag undefine , sender.tag:\(sender.tag)")
            return
        }
        switch buttonTag {
        case .partTime:
            println("兼职")
        case .task:
            println("任务")
        case .credit: 
            println("积分购")
        }
    }
    func leftRightBarButtonClicked(sender:UIBarButtonItem){
        if sender.tag == 0 {
            self.view.endEditing(true)
            self.frostedViewController.presentMenuViewController()
        }else if sender.tag == 1{
            performSegueWithIdentifier(SB.Main.Segue.appCenter, sender: self)
        }
    }
    
    @IBAction func tapGestureHomeMessage(sender: UITapGestureRecognizer) {
        
        self.performSegueWithIdentifier(SB.Main.Segue.homeMessage, sender: self)
    }
    
    //MARK: - private methond
    
    private func checkSignIn(){
        
        guard let phone = UserManager.sharedInstance.getPhoneNumber() where !phone.isEmpty else{
            self.showSignInView()
            return
        }

    }
    
    private func setupHomeView(){
        
        self.navigationController?.mo_hideBackButtonTitle()
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.changeChildView(findPublishType)
        
        self.homeView.fpClosure = { [unowned self] type in
            self.findPublishType = type
        }
        
        self.homeItemView.homeItemClosure = {[unowned self] type in
            switch type {
            case .GPS:
                if self.findPublishType == .FindWork{
                    self.findWorkVc.followMode()
                }
            case .Menu:
                self.performSegueWithIdentifier(SB.Main.Segue.homeMenu, sender: self)
            case .Search:
                self.performSegueWithIdentifier(SB.Main.Segue.homeSearch, sender: self)
            }
        }
    }
    
    
    private func changeChildView(type:FindPublishWork){
    
        func addFindWorkToChild(){
            
            publishWorkVc.view.removeFromSuperview()
            publishWorkVc.removeFromParentViewController()
            
            self.addChildViewController(findWorkVc)
            self.homeView.mapBaseView.addSubview(findWorkVc.view)
            findWorkVc.view.snp_makeConstraints { (make) in
                make.edges.equalTo(findWorkVc.view.superview!)
            }
            findWorkVc.didMoveToParentViewController(self)
            
            self.homeView.mapBaseView.addSubview(homeItemView)
            homeItemView.snp_makeConstraints { (make) in
                make.right.equalTo(homeItemView.superview!).offset(-8)
                make.bottom.equalTo(homeItemView.superview!).offset(-80)
                make.width.equalTo(60)
                make.height.equalTo(180)
            }
        }
        
        func addPublishWorkToChild(){
            
            homeItemView.removeFromSuperview()
            
            findWorkVc.view.removeFromSuperview()
            findWorkVc.removeFromParentViewController()
            
            self.addChildViewController(publishWorkVc)
            self.homeView.mapBaseView.addSubview(publishWorkVc.view)
            publishWorkVc.view.snp_makeConstraints { (make) in
                make.edges.equalTo(publishWorkVc.view.superview!)
            }
            publishWorkVc.didMoveToParentViewController(self)
        }
        
        switch findPublishType {
        case .FindWork:
            addFindWorkToChild()
        case .PublishWork:
            addPublishWorkToChild()
        }
    }
    
    //MARK: - var & let
    var findPublishType:FindPublishWork = .FindWork{
        didSet{
            if findPublishType != oldValue {
                changeChildView(findPublishType)
            }
        }
    }
    
    lazy var leftBarButton:UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        let image = UIImage(named: "homeLeftTop")
        button.setBackgroundImage(image, forState: .Normal)
        button.setTitle("", forState: .Normal)
        button.tag = 0
        button.addTarget(self, action: #selector(leftRightBarButtonClicked(_:)), forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var rightBarButton:UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let image = UIImage(named: "homeRightTop")
        button.setBackgroundImage(image, forState: .Normal)
        button.setTitle("", forState: .Normal)
        button.tag = 1
        button.addTarget(self, action: #selector(leftRightBarButtonClicked(_:)), forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var findWorkVc:FindWorkController = {
        
        return FindWorkController()
    }()
    
    lazy var publishWorkVc:PublishWorkController = {
        
        return PublishWorkController()
    }()
    
    @IBOutlet var homeView: HomeView!
    let homeItemView = HomeItemView()
}
