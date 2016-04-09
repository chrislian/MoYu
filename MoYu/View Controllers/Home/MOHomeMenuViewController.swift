//
//  MOHomeMenuViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOHomeMenuViewController: UIViewController {

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
        
        self.view.endEditing(true)
        self.navigationController?.navigationBar.hidden = false
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }


    //MARK: - event reponse
    @IBAction func leftButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func rightButtonClicked(sender: UIButton) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
