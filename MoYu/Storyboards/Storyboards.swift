//
//  Storyboards.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

struct SB {
    //MARK: - main storyboard
    struct Main {
        struct Cell {
            static let appCenter = "cellAppCenterIdentifier"
        }
        
        struct Segue {
            static let appCenter = "segueAppCener"
        }
        
        struct Vc {
            static func home() -> UIViewController?{
                return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            }
        }
    }
    
    //MARK: - left storyboard
    struct Left {
        struct Cell {
            static let leftMenuCell = "cellLeftMenuIdentifier"
        }
        
        struct Segue {
            static let leftSetting = "segueSetting"
        }
        
        struct Vc {
            static func leftMenu() -> UIViewController?{
                return UIStoryboard(name: "Left", bundle: nil).instantiateInitialViewController()
            }
        }
    }
}