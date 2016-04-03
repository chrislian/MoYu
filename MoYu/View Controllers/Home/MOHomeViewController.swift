//
//  MYHomeViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

enum HomeTitleButtonTag:Int {
    case partTime = 0,task,credit
}

class MOHomeViewController: MOBaseViewController {

    //MARK: - event response
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.mo_hideBackButtonTitle()
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let panGesutre = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        self.view.addGestureRecognizer(panGesutre)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.mo_hideHairLine(true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.mo_hideHairLine(false)
    }

    //MARK: - memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    //MARK: - event response
    @IBAction func titleButtonClicked(sender: AnyObject) {
        guard let buttonTag = HomeTitleButtonTag(rawValue: sender.tag) else{
            print("button tag undefine, sender.tag:\(sender.tag)")
            return
        }
        switch buttonTag {
        case .partTime:
            print("兼职")
        case .task:
            print("任务")
        case .credit: 
            print("积分够")
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
    
    func panGestureRecognized(sender:UIPanGestureRecognizer){
        self.view.endEditing(true)
        self.frostedViewController.panGestureRecognized(sender)
    }
    
    //MARK: - private methond

    
    //MARK: - var & let
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
}
