//
//  SignInController.swift
//  MoYu
//
//  Created by Chris on 16/7/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignInByAuthController: BaseController,SignInType,PraseErrorType {

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
        
        Router.signIn(phone: "18350210050", verifyCode: "1234").request { (status, json) in
            if case .success = status{
                self.dismissSignInView()
            }else{
                self.showError(status)
            }
        }
    }
    
    func authButtonTap(sender:UIButton){
        
        Router.authCode(phone: "18350210050").request { (status, json) in
            self.showSuccess(status)
        }
    }
    

    //MARK: - private method
    private func setupView(){
        
        signInView.enterButton.addTarget(self, action: #selector(enterButtonTap(_:)), forControlEvents: .TouchUpInside)
        signInView.authButton.addTarget(self, action: #selector(authButtonTap(_:)),forControlEvents: .TouchUpInside)
    }

    //MARK: - var & let
    @IBOutlet var signInView: SignInByAuthView!
}
