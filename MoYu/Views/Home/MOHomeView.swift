//
//  MOHomeView.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

typealias FindPublishClosure = (type:FindPublishWork)->Void

class MOHomeView: UIView {

    //MARK: - event response
    @IBAction func selectTypeButtonClicked(sender: UIButton) {
        
        func turnToFindWork(flag:Bool){
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
        
        func turnToPublishWork(flag:Bool){
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
        
        guard let type = FindPublishWork(rawValue: sender.tag) else{
            MOLog("undefine tag")
            return
        }
        
        switch type {
        case .FindWork:
            turnToFindWork(true)
            turnToPublishWork(false)
        case .PublishWork:
            turnToPublishWork(true)
            turnToFindWork(false)
        }
        
        //closure
        if let closure = fpClosure {
            closure(type: type)
        }
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var mapBaseView: UIView!
    @IBOutlet private weak var timeLineLabel: UIView!
    @IBOutlet private weak var timeTitleLabel: UILabel!
    @IBOutlet private weak var timeImageView: UIImageView!
    
    @IBOutlet private weak var workLineLabel: UIView!
    @IBOutlet private weak var workTitleLabel: UILabel!
    @IBOutlet private weak var workImageView: UIImageView!
    
    var fpClosure:FindPublishClosure?
}
