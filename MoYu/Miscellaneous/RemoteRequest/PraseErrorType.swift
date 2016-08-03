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
    func showError(status:NetworkActionStatus,showSuccess:Bool)
    
    func showSuccess(status: NetworkActionStatus)
}

extension PraseErrorType where Self: BaseController{
    
    func showError(status: NetworkActionStatus ,showSuccess:Bool = false){
    
        switch status {
        case .userFailure(let message):
            SVProgressHUD.showErrorWithStatus(message)
        case .systemFailure(let message):
            SVProgressHUD.showErrorWithStatus(message)
        case .networkFailure(let message):
            SVProgressHUD.showErrorWithStatus(message)
        case .otherFailure(let message):
            SVProgressHUD.showErrorWithStatus(message)
        case .userNeedLogin: 
            self.showSignInView()
        case .success(let message):
            if showSuccess{
                SVProgressHUD.showSuccessWithStatus(message)
            }
        }
    }
    
    func showSuccess(status: NetworkActionStatus){
        
        switch status{
        case .success(let message):
            SVProgressHUD.showSuccessWithStatus(message)
        default:
            break
        }
    }
    
    func showError(message message:String){
        
        SVProgressHUD.showErrorWithStatus(message)
    }
    
}