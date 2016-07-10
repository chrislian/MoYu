//
//  MOSignInController.swift
//  MoYu
//
//  Created by Chris on 16/7/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class SignInByAuthController: UIViewController {

    //MARK: - private method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
    }
    
    //MARK: - event reponse
    func enterButtonTap(sender: UIButton){
        MOLog("sign in")
    }
    
    func authButtonTap(sender:UIButton){
        MOLog("auth button")
    }
    

    //MARK: - private method
    private func setupView(){
        //set navigationBar opaque false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        
        signInView.enterButton.addTarget(self, action: #selector(enterButtonTap(_:)), forControlEvents: .TouchUpInside)
        signInView.authButton.addTarget(self, action: #selector(authButtonTap(_:)),forControlEvents: .TouchUpInside)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - var & let
    @IBOutlet var signInView: SignInByAuthView!
}
