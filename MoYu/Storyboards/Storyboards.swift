//
//  Storyboards.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

struct SB {
    
    //MARK: - sign in storybaord
    struct SignIn {
        struct Vc{
            static func signIn()->UIViewController?{
                return UIStoryboard(name: "SignIn", bundle: nil).instantiateInitialViewController()
            }
        }
    }
    
    //MARK: - main storyboard
    struct Main {
        struct Cell {
            static let homeMessage = "cellHomeMessageIdentifier"
            static let homeMenu  = "cellHomeMenuIdentifier"
        }
        
        struct Segue {
            static let appCenter = "segueAppCener"
            static let homeMessage = "segueHomeMessage"
            static let homeMenu = "segueHomeMenu"
            static let homeSearch = "segueHomeSearch"
        }
        
        struct Vc {
            static func home() -> UIViewController?{
                return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            }
        }
    }
    
    //MARK: - left storyboard
    struct Personal {
        
        struct Cell {
            static let leftMenuCell = "cellLeftMenuIdentifier"
            static let accountBindingCell = "cellAccountBindingIdentifier"
            static let userHeaderCell = "segueUseHeaderIdentifier"
            static let myPurseCell = "cellMyPurseIdentifier"
        }
        
        struct Segue {
            static let leftSetting = "segueSetting"
            static let userGuide = "segueUserGuide"
            static let accountBinding = "segueAccountBinding"
            static let myPurse = "segueMyPurse"
        }
        
        struct Vc {
            static func leftMenu() -> UIViewController?{
                return UIStoryboard(name: "Personal", bundle: nil).instantiateInitialViewController()
            }
        }
    }
    
    //MARK: - right stroyboard
    struct AppCenter{
        
        struct Cell{
            static let appCenter = "cellAppCenterIdentifier"
            static let aboutJobs = "cellAboutJobsIdentifier"
        }
        struct Segue{
            static let aboutJobs = "segueAboutJobs"
            static let personMsg = "seguePersonMessage"
            static let publishMsg = "seguePublishMessage"
        }
        
        struct Vc{
        
        }
    }
}