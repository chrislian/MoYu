//
//  AppCenterController.swift
//  MoYu
//
//  Created by Chris on 16/4/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AppCenterController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "应用中心"
        self.setupAppCenterView()
    }
    
    //MARK: - memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    //MARK: - private method
    private func setupAppCenterView(){
        tableView.backgroundColor = UIColor.mo_background()
        bannerView.backgroundColor = UIColor.mo_background()
        
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
    }
    
    //MARK: - var & let
    
    let cellTitles = [["职来职往"],["附近的人","积分购","任务大厅"]]
    let cellImages = [[UIImage(named:"rightAppCenterWork")!],
                      [UIImage(named:"rightAppCenterNear")!,
                      UIImage(named:"rightAppCenterCreidt")!,
                      UIImage(named:"rightAppCenterTask")!]]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: UIView!
}

extension AppCenterController:UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0  {
            self.performSegueWithIdentifier(SB.AppCenter.Segue.aboutJobs, sender: self)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor  = UIColor.mo_background()
        return view
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor  = UIColor.mo_background()
        return view
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tmpCell = cell as? AppCenterCell else{
            println("cell error")
            return
        }
        tmpCell.updateCell(cellImages[indexPath.section][indexPath.row], text: cellTitles[indexPath.section][indexPath.row])
    }
}

extension AppCenterController:UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellTitles.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(SB.AppCenter.Cell.appCenter){
            return cell
        }
        
        return LeftMenuCell(style: .Default, reuseIdentifier: SB.AppCenter.Cell.appCenter)
    }
}
