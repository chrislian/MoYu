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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? TaskAppTestController{
            vc.taskModel = selectModel
        }else if let vc = segue.destinationViewController as? TaskHandbillController{
            vc.taskModel = selectModel
        }
    }
    
    //MARK: - event response
    
    @objc fileprivate func segmentedControlChanged(){
        
        if selectedType.rawValue == segmentedView.selectedIndex{
            return
        }
        
        guard let type = TaskDetailType(rawValue: segmentedView.selectedIndex) else{ return }
        
        selectedType = type
    }
    
    //MARK: - private method
    
    fileprivate func setupView(){
        
        titleView.tapClourse = { [unowned self] type in
            if type != .middle{
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        headerView.backgroundColor = UIColor.mo_background()
        subView.backgroundColor = UIColor.mo_background()
        
        headerView.addSubview(segmentedView)
        
        addChildViewController(pageController)
        subView.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)
        
        pageController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(subView)
        }
        selectedType = .all
    }
    
    fileprivate func taskDetail(by type:TaskDetailType) -> TaskDetailController{
        
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
        
        vc.selectClourse = { [unowned self] (model) in
            
            self.selectModel = model
            
            switch model.type {
            case "1":
                self.performSegueWithIdentifier(SB.Task.Segue.appExperience, sender: nil)
            case "2":
                self.performSegueWithIdentifier(SB.Task.Segue.handbill, sender: nil)
                
            case "3":
                //TODO: - other
                break
            default:
                break
            }
        }
        return vc
    }
    
    
    //MARK: - var & let
    fileprivate lazy var titleView: TopTitleView = {
        let view = TopTitleView(frame: CGRect(x: 0, y: 0, width: 240, height: 43 ), type:.middle)
        return view
    }()
    
    fileprivate lazy var subControllers:[UIViewController] = {
        
        return (0...3).flatMap{ TaskDetailType(rawValue: $0) }.map( self.taskDetail )
    }()
    
    
    fileprivate var selectModel:TaskModel?
    
    fileprivate var pageController:UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.view.backgroundColor = UIColor.mo_background()
        return vc
    }()
    
    fileprivate lazy var segmentedView:SegmentedControl = {
        let control = SegmentedControl(frame: CGRect(x: 0, y: 0, width: MoScreenWidth, height: 36))
        control.segments = ["全部","应用体验","问卷调查","其他"]
        control.backgroundColor = UIColor.white
        control.selectedTitleColor = UIColor.mo_main()
        control.titleColor = UIColor.mo_lightBlack()
        control.highlightedTitleColor = UIColor.mo_lightBlack()
        control.selectedBackgroundColor = UIColor.mo_main()
        control.selectedBackgroundViewHeight = 2
        control.titleFontSize = 15
        control.addTarget(self, action: #selector(TaskController.segmentedControlChanged), for: .touchUpInside)
        return control
    }()
    
    fileprivate var selectedType:TaskDetailType = .all{
        didSet{

            pageController.setViewControllers([subControllers[selectedType.rawValue]], direction: .forward, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subView: UIView!
}
