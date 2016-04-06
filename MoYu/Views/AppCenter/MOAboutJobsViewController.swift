//
//  MOAboutJobsViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOAboutJobsViewController: UIViewController {

    //MARK: -  life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "职来职往"
        self.setupView()
    }
    
    
    //MARK: - event response
    func rightBarButtonClicked(sender:UIButton){
        self.performSegueWithIdentifier(SB.Main.Segue.personMsg, sender: self)
    }
    
    //MARK: - private method
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    
    lazy var rightBarButton:UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"icon_message")
        button.setBackgroundImage(image, forState: .Normal)
        button.setTitle("", forState: .Normal)
        button.tag = 1
        button.addTarget(self, action: #selector(rightBarButtonClicked(_:)), forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
}

extension MOAboutJobsViewController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.selectionStyle = .None
    }
}

extension MOAboutJobsViewController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Main.Cell.aboutJobs) else{
            return MOAboutJobsCell(style: .Default, reuseIdentifier:SB.Main.Cell.aboutJobs)
        }
        return cell
    }
}
