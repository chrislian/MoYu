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
            static func root()->UIViewController?{
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
            static let selectCity = "segueSelectCity"
            
        }
        
        struct Vc {
            static func root() -> UIViewController?{
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
            static let messageCenterCell = "cellMessageCenterIdenetifier"
            static let parttimeJobCell = "cellParttimeJobIdentifier"
        }
        
        struct Segue {
            static let myPurse = "segueMyPurse"
            static let withdraw = "segueWithdraw"
            static let userInfo = "segueUserInfo"
            static let messageCenter = "segueMessageCenter"
            static let recommend = "segueRecommned"
            static let recuritCenter = "segueRecruit"
            static let parttimeJob = "seguePartTimeJob"
        }
        
        struct Vc {
            static func root() -> UIViewController?{
                return UIStoryboard(name: "Personal", bundle: nil).instantiateInitialViewController()
            }
        }
    }
    
    struct Setting {
        
        struct Segue {
            static let userGuide = "segueUserGuide"
            static let accountBinding = "segueAccountBinding"
            static let legalProvisions = "segueLegalProvisions"
        }
        
        struct Vc{
            static func root() -> UIViewController?{
                return UIStoryboard(name: "Setting", bundle: nil).instantiateInitialViewController()
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