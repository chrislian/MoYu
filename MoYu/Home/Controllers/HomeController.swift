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
        
        mapController.mapViewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.mo_hide(hairLine: false)
        
        mapController.mapViewWillDisappear()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination.childViewControllers.last as? HomeMenuController {
            vc.location = mapController.currentLocation
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
        
        
        homeView.mapBaseView.addSubview(mapController.view)
        mapController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(homeView.mapBaseView)
        }
        mapController.didMove(toParentViewController: self)
        findPublishType = .findWork
        
        mapController.findWorkLeftView.homeItemClosure = {[unowned self] type in
            switch type {
            case .gps:
                if self.findPublishType == .findWork{
                    self.mapController.followMode()
                }
            case .menu:
                self.performSegue(withIdentifier: SB.Main.Segue.homeMenu, sender: self)
            case .search:
                self.performSegue(withIdentifier: SB.Main.Segue.homeSearch, sender: self)
            }
        }
        mapController.publishClourse = {[unowned self] in
            self.navigationController?.pushViewController($0, animated: true)
        }
        
        homeView.fpClosure = { [unowned self] type in
            self.findPublishType = type
        }
    }
    
    
    //MARK: - var & let
    var findPublishType:FindPublishWork = .findWork{
        didSet{
            mapController.mapType = findPublishType
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
    
    lazy var mapController:HomeMapController = {
        return HomeMapController()
    }()
    
    @IBOutlet var homeView: HomeView!
}
