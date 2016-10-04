//
//  SignInType.swift
//  MoYu
//
//  Created by Chris on 16/7/18.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


protocol SignInType {
    
    func showSignInView(_ completion: ((Void)->Void)?)
    
    func dismissSignInView( _ completion: ((Void)->Void)? )
}

extension SignInType where Self: UIViewController{
    
    func showSignInView(_ completion: ((Void)->Void)? = nil ){
        
        guard let nav = SB.SignIn.root else{
            println("load signin failed")
            return
        }
        
        self.present(nav, animated: true, completion: completion)
    }
    
    func dismissSignInView( _ completion: ((Void)->Void)? = nil ){
        
        self.dismiss(animated: true, completion: completion )
    }
}
