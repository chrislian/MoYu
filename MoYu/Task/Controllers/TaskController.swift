//
//  TaskController.swift
//  MoYu
//
//  Created by Chris on 16/9/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class TaskController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleView

        setupView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? TaskAppTestController{
            vc.taskModel = selectModel
        }
        
    }
    
    //MARK: - event response
    
    @objc private func segmentedControlChanged(){
        
        if selectedType.rawValue == segmentedView.selectedIndex{
            return
        }
        
        guard let type = TaskDetailType(rawValue: segmentedView.selectedIndex) else{ return }
        
        selectedType = type
    }
    
    //MARK: - private method
    
    private func setupView(){
        
        titleView.tapClourse = { [unowned self] type in
            if type != .middle{
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        headerView.backgroundColor = UIColor.mo_background()
        subView.backgroundColor = UIColor.mo_background()
        
        headerView.addSubview(segmentedView)
        
        addChildViewController(pageController)
        subView.addSubview(pageController.view)
        pageController.didMoveToParentViewController(self)
        
        pageController.view.snp_makeConstraints { (make) in
            make.edges.equalTo(subView)
        }
        selectedType = .all
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
    
    private lazy var subControllers:[UIViewController] = {
        
        return (0...3).flatMap{ TaskDetailType(rawValue: $0) }.map( self.taskDetail )
    }()
    
    
    private var selectModel:TaskModel?
    
    private var pageController:UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        vc.view.backgroundColor = UIColor.mo_background()
        return vc
    }()
    
    private lazy var segmentedView:SegmentedControl = {
        let control = SegmentedControl(frame: CGRect(x: 0, y: 0, width: MoScreenWidth, height: 36))
        control.segments = ["全部","应用体验","问卷调查","其他"]
        control.backgroundColor = UIColor.whiteColor()
        control.selectedTitleColor = UIColor.mo_main()
        control.titleColor = UIColor.mo_lightBlack()
        control.highlightedTitleColor = UIColor.mo_lightBlack()
        control.selectedBackgroundColor = UIColor.mo_main()
        control.selectedBackgroundViewHeight = 2
        control.titleFontSize = 15
        control.addTarget(self, action: #selector(TaskController.segmentedControlChanged), forControlEvents: .TouchUpInside)
        return control
    }()
    
    private var selectedType:TaskDetailType = .all{
        didSet{

            pageController.setViewControllers([subControllers[selectedType.rawValue]], direction: .Forward, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subView: UIView!
}
