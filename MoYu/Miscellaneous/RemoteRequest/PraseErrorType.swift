//
//  PraseErrorType.swift
//  MoYu
//
//  Created by Chris on 16/8/2.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SVProgressHUD

enum NetworkActionStatus{
    case success(message:String)
    case userNeedLogin
    case userFailure(message:String)
    case systemFailure(message:String)
    case networkFailure(message:String)
    case otherFailure(message:String)
}

protocol PraseErrorType : SignInType {
    
    func show(error status:NetworkActionStatus,showSuccess:Bool)
    
    func show(success status: NetworkActionStatus)
}

extension PraseErrorType where Self: BaseController{
    
    func show(error status: NetworkActionStatus ,showSuccess:Bool = false){
    
        switch status {
        case .userFailure(let message):
            self.show(message: message)
        case .systemFailure(let message):
            self.show(message: message)
        case .networkFailure(let message):
            self.show(message: message)
        case .otherFailure(let message):
            self.show(message: message)
        case .userNeedLogin: 
            self.showSignInView()
        case .success(let message):
            if showSuccess{
                self.show(message: message)
            }
        }
    }
    
    func show(success status: NetworkActionStatus){
        
        switch status{
        case .success(let message):
            self.show(message: message)
        default:
            break
        }
    }
}