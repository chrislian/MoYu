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
        static var root:UIViewController?{
            return SB.vc(storyboard: "SignIn")
        }
    }
    
    //MARK: - main storyboard
    struct Main {
        struct Cell {
            static let homeMessage = "cellHomeMessageIdentifier"
            static let homeMenu  = "cellHomeMenuIdentifier"
            static let parttimeContent = "cellParttimeJobContentIdentifier"
        }
        
        struct Segue {
            static let appCenter = "segueAppCener"
            static let homeMessage = "segueHomeMessage"
            static let homeMenu = "segueHomeMenu"
            static let homeSearch = "segueHomeSearch"
            static let selectCity = "segueSelectCity"
            static let getParttimeJob = "segueGetParttimeJob"
            static let homeParttimeJobDetail = "segueHomeGetParttimeJob"
            
        }
        
        static var root:UIViewController?{
            return SB.vc(storyboard: "Main")
        }
    }
    
    //MARK: - personal storyboard
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
        
        static var root:UIViewController?{
            return SB.vc(storyboard: "Personal")
        }
    }
    
    //MARK: - setting storyboard
    struct Setting {
        
        struct Segue {
            static let userGuide = "segueUserGuide"
            static let accountBinding = "segueAccountBinding"
            static let legalProvisions = "segueLegalProvisions"
        }
        
        static var root:UIViewController?{
            return SB.vc(storyboard: "Setting")
        }
    }
    
    
    //MARK: - right stroyboard
    struct AppCenter{
        
        struct Cell{
            static let appCenter = "cellAppCenterIdentifier"
            static let aboutJobs = "cellAboutJobsIdentifier"
            static let commentsTop = "cellCommentsTopIdentifier"
            static let commentsSub = "cellCommentSubIdentifier"
            static let aroundPeople = "cellAroundPeopleIdentifier"
        }
        struct Segue{
            static let aboutJobs = "segueAboutJobs"
            static let personMsg = "seguePersonMessage"
            static let publishMsg = "seguePublishMessage"
            static let comments = "segueComments"
            static let aroundPeople = "segueAroundPeople"
            static let peopleHomePage = "seguePeopleHomePage"
            static let socialNavi = "segueSocial"
        }
        
        static var root:UIViewController?{
            return SB.vc(storyboard: "AppCenter")
        }
    }
    
    //MARK: - social storyboard
    struct Social {
        struct Cell {
            
        }
        
        struct Segue {
            
        }
        
        static var root:UIViewController?{
            
            return SB.vc(storyboard: "Social")
        }
    }
    
    
    //MARK: - task storyboard
    struct Task {
        struct Cell {
            static let appExperience = "cellAppExperience"
        }
        
        struct Segue {
            static let appExperience = "segueTaskAppExperience"
            static let handbill = "segueHandbill"
        }
        
        static var root:UIViewController?{
            return SB.vc(storyboard: "Task")
        }
    }
}

// MARK: - Storyboard 方法
extension SB{

    /**
     从 `storyboard`获取 root view controller
     
     - parameter name:       storyboard name
     - parameter bundle:     bundle id
     
     - returns: UIViewController
     */
    static func vc(storyboard name:String, bundle:Bundle? = nil)->UIViewController?{
        
        return UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController()
    }
    
    /**
     从 `storyboard`获取制定的vc
     
     - parameter name:       storyboard name
     - parameter bundle:     bundle
     - parameter identifier:
     
     - returns: UIViewController
     */
    static func vc(storyboard name:String, bundle:Bundle? = nil, identifier:String)-> UIViewController{
        
        return UIStoryboard(name: name, bundle: bundle).instantiateViewController(withIdentifier: identifier)
    }
}
