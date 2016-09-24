//
//  TaskController.swift
//  MoYu
//
//  Created by Chris on 16/9/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import NinaPagerView

class TaskController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleView

        setupView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        pagerView = NinaPagerView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? TaskAppTestController{
            vc.taskModel = selectModel
        }
        
    }
    
    //MARK: - private method
    
    private func setupView(){
        
        titleView.tapClourse = { [unowned self] type in
            if type != .middle{
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        self.view.addSubview(pagerView)
        pagerView.frame = view.bounds
    }
    
    private func taskDetail(by type:TaskDetailType) -> TaskDetailController{
        
        let vc = TaskDetailController()
        vc.taskDetailType = type
        
        switch type{
        case .all:
            vc.title = "全部"
        case .appExperience:
            vc.title = "应用体验"
        case .handbill:
            vc.title = "问卷调查"
        case .other:
            vc.title = "其他"
        }
        
        vc.selectClourse = { [unowned self] (type,model) in
            
            self.selectModel = model
            
            switch type {
            case .appExperience:
                self.performSegueWithIdentifier(SB.Task.Segue.appExperience, sender: nil)
            case .handbill:
                self.performSegueWithIdentifier(SB.Task.Segue.handbill, sender: nil)
            default:
                break
            }
        }
        return vc
    }
    
    
    //MARK: - var & let
    private lazy var titleView: TopTitleView = {
        let view = TopTitleView(frame: CGRect(x: 0, y: 0, width: 240, height: 43 ), type:.middle)
        return view
    }()
    
    private lazy var pagerView: NinaPagerView = {
    
        let controllers = (0...3).flatMap{ TaskDetailType(rawValue: $0) }.map( self.taskDetail )
        
        let titles = controllers.flatMap{ $0.title }

        let pagerView = NinaPagerView(frame: CGRect.zero, withTitles: titles, withVCs: controllers)
        
        pagerView.selectTitleColor = UIColor.mo_main()
        pagerView.unSelectTitleColor = UIColor.mo_lightBlack()
        pagerView.underlineColor = UIColor.mo_main()
        
        return pagerView
    }()
    
    private var selectModel:TaskModel?
}
