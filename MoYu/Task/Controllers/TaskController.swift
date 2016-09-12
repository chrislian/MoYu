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
    
    
    //MARK: - var & let
    lazy var titleView: TopTitleView = {
        let view = TopTitleView(frame: CGRect(x: 0, y: 0, width: 240, height: 43 ), type:.middle)
        return view
    }()
    
    var pagerView: NinaPagerView = {
        let colors = [UIColor.mo_main(), UIColor.mo_lightBlack(), UIColor.mo_main(),UIColor.whiteColor()]
        let vcs = [UIViewController(),UIViewController(),UIViewController(),UIViewController()]
        let pagerView = NinaPagerView(frame: CGRect.zero, withTitles: ["全部","应用体验过", "问卷调查", "其他"], withVCs: vcs)
        return pagerView
    }()
}
