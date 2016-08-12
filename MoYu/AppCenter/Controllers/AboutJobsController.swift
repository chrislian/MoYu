//
//  AboutJobsController.swift
//  MoYu
//
//  Created by Chris on 16/4/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SwiftyJSON

class AboutJobsController: BaseController {

    //MARK: -  life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "职来职往"
        self.setupView()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Router.aboutJob(page: 1).request { [weak self] (status, json) in
            
            self?.show(error: status)
            
            self?.updateJob(list: json)
        }
    }
    
    
    
    //MARK: - event response
    func rightBarButtonClicked(sender:UIButton){
        self.performSegueWithIdentifier(SB.AppCenter.Segue.personMsg, sender: self)
    }
    
    func publishButtonClicked(sender:UIButton){
        self.performSegueWithIdentifier(SB.AppCenter.Segue.publishMsg, sender: self)
    }
    
    //MARK: - private method
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(publishButton)
        publishButton.snp_makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.right.equalTo(publishButton.superview!).offset(-30)
            make.bottom.equalTo(publishButton.superview!).offset(-60)
        }
    }
    
    
    private func updateJob(list json:JSON?){
        
        aboutJobModel = AboutJobModel(json: json)
        if aboutJobModel.items.count > 0{
            tableView.reloadData()
        }
    }
    
    
    //MARK: - var & let
    
    var aboutJobModel = AboutJobModel()
    
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
    
    lazy var publishButton:UIButton = {
        let button = UIButton(type: .Custom)
        button.setTitle("", forState: .Normal)
        button.contentMode = .ScaleAspectFit
        button.setImage(UIImage(named:"icon_publish"), forState: .Normal)
        button.addTarget(self, action: #selector(publishButtonClicked(_:)), forControlEvents: .TouchUpInside)
        return button
    }()
}

extension AboutJobsController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.selectionStyle = .None
        
        guard let cell = cell as? AboutJobsCell else{
            return
        }
        cell.update(item: aboutJobModel.items[indexPath.section])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension AboutJobsController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return aboutJobModel.items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return AboutJobsCell.cell(tableView: tableView)
    }
}
