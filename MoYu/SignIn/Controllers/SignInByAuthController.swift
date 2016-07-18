//
//  SignInController.swift
//  MoYu
//
//  Created by Chris on 16/7/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class SignInByAuthController: BaseController,SignInType {

    //MARK: - private method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationBarOpaque = false
    }
    
    
    //MARK: - event reponse
    func enterButtonTap(sender: UIButton){
        println("sign in")
        
        Router.SignIn(phone: "18350210050", verifyCode: "1234").request { (statusCode, message, json) in
            println("satusCode:\(statusCode)")
            println("message:\(message)")
            println("json:\(json)")
        }
        
        self.dismissSignInView()
    }
    
    func authButtonTap(sender:UIButton){
        println("auth button")
    }
    

    //MARK: - private method
    private func setupView(){
        
        signInView.enterButton.addTarget(self, action: #selector(enterButtonTap(_:)), forControlEvents: .TouchUpInside)
        signInView.authButton.addTarget(self, action: #selector(authButtonTap(_:)),forControlEvents: .TouchUpInside)
    }

    //MARK: - var & let
    @IBOutlet var signInView: SignInByAuthView!
}
