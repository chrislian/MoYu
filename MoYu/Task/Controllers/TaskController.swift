//
//  TaskController.swift
//  MoYu
//
//  Created by Chris on 16/9/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class TaskController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleView
        titleView.tapClourse = { [unowned self] type in
            if type != .middle{
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        view.backgroundColor = UIColor ( red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0 )
        
    }
    
    
    lazy var titleView: TopTitleView = {
        let view = TopTitleView(frame: CGRect(x: 0, y: 0, width: 240, height: 43 ), type:.middle)
        return view
    }()
}
