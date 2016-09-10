//
//  MessageCenterController.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MessageCenterController: UIViewController,PraseErrorType, AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        mo_navigationBar(title: "消息中心")
        
        navigationItem.leftBarButtonItems = leftBarButtonItems
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateMessage()
    }
    
    
    //MARK: - event response
    
    func backButton(tap sender:AnyObject){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        tableView.backgroundColor = UIColor.mo_background()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .None
    }
    
    private func updateMessage(){
        
        Router.messageCenter.request { (status, json) in
            
            self.show(error: status)
            
            if let data = json, case .success = status{
                
                self.messageModel.prase(response: data)
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    
    lazy var messageModel = MessageCenterModel()
    
    private lazy var leftBarButtonItems:[UIBarButtonItem] = {
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil , action: nil)
        spaceItem.width = 1//-16
        let barButton = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .Done, target: self, action: #selector(MessageCenterController.backButton(tap:)))
        return [spaceItem, barButton]
    }()
    
    var alertView: OLGhostAlertView = OLGhostAlertView()
    var alertLock: NSLock = NSLock()
}

extension MessageCenterController: UITableViewDelegate{

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell  = cell as? MessageCenterCell else{
            return
        }
        cell.update(item: messageModel.items[indexPath.section] )
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        vc.title = "详情"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MessageCenterController: UITableViewDataSource{

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return messageModel.items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = MessageCenterCell.cell(tableView: tableView)
        cell.accessoryType = .None
        return cell
    }
}
