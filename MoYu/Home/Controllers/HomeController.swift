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
    
    case findWork = 100,publishWork
}


class HomeController: UIViewController {

    //MARK: - event response
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHomeView()
        
        navigationController?.mo_hideBackButtonTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.mo_hide(hairLine: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.mo_hide(hairLine: false)
    }

    //MARK: - memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination.childViewControllers.last as? HomeMenuController {
            vc.location = findWorkVc.location
        }
        
    }
    
    //MARK: - event response
    @IBAction func titleButtonClicked(_ sender: AnyObject) {
        guard let buttonTag = HomeTitleButtonTag(rawValue: sender.tag) else{
//            println("button tag undefine , sender.tag:\(sender.tag)")
            return
        }
        switch buttonTag {
        case .partTime:
            println("兼职")
        case .task:
            println("任务")
            guard let vc = SB.Task.root else{ return }
            present(vc, animated: true, completion: nil)
        case .credit: 
            println("积分购")
        }
    }
    func leftRightBarButtonClicked(_ sender:UIBarButtonItem){
        if sender.tag == 0 {
            self.view.endEditing(true)
            self.frostedViewController.presentMenuViewController()
        }else if sender.tag == 1{
            performSegue(withIdentifier: SB.Main.Segue.appCenter, sender: self)
        }
    }
    
    @IBAction func tapGestureHomeMessage(_ sender: UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: SB.Main.Segue.homeMessage, sender: self)
    }
    
    //MARK: - private methond
    
    fileprivate func setupHomeView(){
        
        self.navigationController?.mo_hideBackButtonTitle()
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.changeChildView(findPublishType)
        
        self.homeView.fpClosure = { [unowned self] type in
            self.findPublishType = type
        }
        
        self.homeItemView.homeItemClosure = {[unowned self] type in
            switch type {
            case .gps:
                if self.findPublishType == .findWork{
                    self.findWorkVc.followMode()
                }
            case .menu:
                self.performSegue(withIdentifier: SB.Main.Segue.homeMenu, sender: self)
            case .search:
                self.performSegue(withIdentifier: SB.Main.Segue.homeSearch, sender: self)
            }
        }
    }
    
    
    fileprivate func changeChildView(_ type:FindPublishWork){
    
        func addFindWorkToChild(){
            
            publishWorkVc.view.removeFromSuperview()
            publishWorkVc.removeFromParentViewController()
            
            self.addChildViewController(findWorkVc)
            self.homeView.mapBaseView.addSubview(findWorkVc.view)
            findWorkVc.view.snp.makeConstraints { (make) in
                make.edges.equalTo(findWorkVc.view.superview!)
            }
            findWorkVc.didMove(toParentViewController: self)
            
            self.homeView.mapBaseView.addSubview(homeItemView)
            homeItemView.snp.makeConstraints { (make) in
                make.right.equalTo(homeItemView.superview!).offset(-8)
//                make.bottom.equalTo(homeItemView.superview!).offset(-80)
                make.centerY.equalTo(homeItemView.superview!).offset(-80)
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
            publishWorkVc.view.snp.makeConstraints { (make) in
                make.edges.equalTo(publishWorkVc.view.superview!)
            }
            publishWorkVc.didMove(toParentViewController: self)
        }
        
        switch findPublishType {
        case .findWork:
            addFindWorkToChild()
        case .publishWork:
            addPublishWorkToChild()
        }
    }
    
    //MARK: - var & let
    var findPublishType:FindPublishWork = .findWork{
        didSet{
            if findPublishType != oldValue {
                changeChildView(findPublishType)
            }
        }
    }
    
    lazy var leftBarButton:UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        let image = UIImage(named: "homeLeftTop")
        button.setBackgroundImage(image, for: UIControlState())
        button.setTitle("", for: UIControlState())
        button.tag = 0
        button.addTarget(self, action: #selector(leftRightBarButtonClicked(_:)), for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var rightBarButton:UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let image = UIImage(named: "homeRightTop")
        button.setBackgroundImage(image, for: UIControlState())
        button.setTitle("", for: UIControlState())
        button.tag = 1
        button.addTarget(self, action: #selector(leftRightBarButtonClicked(_:)), for: .touchUpInside)
        
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
