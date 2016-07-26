//
//  SignInType.swift
//  MoYu
//
//  Created by Chris on 16/7/18.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


protocol SignInType {
    
    func showSignInView(completion: (Void->Void)?)
    
    func dismissSignInView( completion: (Void->Void)? )
}

extension SignInType where Self: UIViewController{
    
    func showSignInView(completion: (Void->Void)? = nil ){
        
        guard let nav = SB.SignIn.Vc.root() else{
            println("load signin failed")
            return
        }
        
        self.presentViewController(nav, animated: true, completion: completion)
    }
    
    func dismissSignInView( completion: (Void->Void)? = nil ){
        
        self.dismissViewControllerAnimated(true, completion: completion )
    }
}