//
//  MOHomeView.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

enum HomeTimeWorkType:Int {
    
    case HasTime = 0,HasWork
}

class MOHomeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func selectTypeButtonClicked(sender: UIButton) {
        
        func changeHasTime(flag:Bool){
            if flag {
                timeLineLabel.backgroundColor = UIColor.mo_mainColor()
                timeTitleLabel.textColor = UIColor.mo_mainColor()
                timeImageView.image = UIImage(named: "home_have_time_selected")
            }else{
                timeLineLabel.backgroundColor = UIColor.mo_mercuryColor()
                timeTitleLabel.textColor = UIColor.grayColor()
                timeImageView.image = UIImage(named: "home_have_time_unselected")
            }
        }
        
        func changeHasWork(flag:Bool){
            if flag {
                workLineLabel.backgroundColor = UIColor.mo_mainColor()
                workTitleLabel.textColor = UIColor.mo_mainColor()
                workImageView.image = UIImage(named: "home_have_work_selected")
            }else{
                workLineLabel.backgroundColor = UIColor.mo_mercuryColor()
                workTitleLabel.textColor = UIColor.grayColor()
                workImageView.image = UIImage(named: "home_have_work_unseleted")
            }
        }
        
        guard let type = HomeTimeWorkType(rawValue: sender.tag) else{
            MOLog("undefine tag")
            return
        }
        
        switch type {
        case .HasTime:
            changeHasTime(true)
            changeHasWork(false)
        case .HasWork:
            changeHasWork(true)
            changeHasTime(false)
        }
        
    }
    @IBOutlet weak var timeLineLabel: UIView!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var timeImageView: UIImageView!
    
    @IBOutlet weak var workLineLabel: UIView!
    @IBOutlet weak var workTitleLabel: UILabel!
    @IBOutlet weak var workImageView: UIImageView!
}
