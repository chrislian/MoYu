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
    
    
    //MARK: - private method
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
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
