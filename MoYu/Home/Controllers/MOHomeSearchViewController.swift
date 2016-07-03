//
//  MOHomeSearchViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOHomeSearchViewController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.hidden = false
    }
    
    //MARK: - event response
    
    @IBAction func cancelButtonClicked(sender: UIButton) {
        
        self.view.endEditing(true)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK: - private method
    
    //MARK: - var & let


}
