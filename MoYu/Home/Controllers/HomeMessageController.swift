//
//  MessageController.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeMessageController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        setupMessageView()
    }


    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    //MARK: - private method
    private func setupMessageView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.mo_mercury()
    }

    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
}


//MARK: - table view delegate
extension HomeMessageController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


//MARK: - table view data source
extension HomeMessageController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Main.Cell.homeMessage) else{
            return HomeMessageCell(style: .Default, reuseIdentifier: SB.Main.Cell.homeMessage)
        }
        return cell
    }
}
