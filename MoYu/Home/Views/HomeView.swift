//
//  HomeView.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

typealias FindPublishClosure = (_ type:FindPublishWork)->Void

class HomeView: UIView {

    //MARK: - event response
    @IBAction func selectTypeButtonClicked(_ sender: UIButton) {
        
        func turnToFindWork(_ flag:Bool){
            if flag {
                timeLineLabel.backgroundColor = UIColor.mo_main()
                timeTitleLabel.textColor = UIColor.mo_main()
                timeImageView.image = UIImage(named: "home_have_time_selected")
            }else{
                timeLineLabel.backgroundColor = UIColor.mo_mercury()
                timeTitleLabel.textColor = UIColor.gray
                timeImageView.image = UIImage(named: "home_have_time_unselected")
            }
        }
        
        func turnToPublishWork(_ flag:Bool){
            if flag {
                workLineLabel.backgroundColor = UIColor.mo_main()
                workTitleLabel.textColor = UIColor.mo_main()
                workImageView.image = UIImage(named: "home_have_work_selected")
            }else{
                workLineLabel.backgroundColor = UIColor.mo_mercury()
                workTitleLabel.textColor = UIColor.gray
                workImageView.image = UIImage(named: "home_have_work_unseleted")
            }
        }
        
        guard let type = FindPublishWork(rawValue: sender.tag) else{
            println("undefine tag")
            return
        }
        
        switch type {
        case .findWork:
            turnToFindWork(true)
            turnToPublishWork(false)
        case .publishWork:
            turnToPublishWork(true)
            turnToFindWork(false)
        }
        
        //closure
        if let closure = fpClosure {
            closure(type)
        }
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var mapBaseView: UIView!
    @IBOutlet fileprivate weak var timeLineLabel: UIView!
    @IBOutlet fileprivate weak var timeTitleLabel: UILabel!
    @IBOutlet fileprivate weak var timeImageView: UIImageView!
    
    @IBOutlet fileprivate weak var workLineLabel: UIView!
    @IBOutlet fileprivate weak var workTitleLabel: UILabel!
    @IBOutlet fileprivate weak var workImageView: UIImageView!
    
    var fpClosure:FindPublishClosure?
}
