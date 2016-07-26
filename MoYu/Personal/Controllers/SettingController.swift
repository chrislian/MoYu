//
//  SettingController.swift
//  MoYu
//
//  Created by Chris on 16/7/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class SettingController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "设置"
        
        self.setupView()
    }

    
    //MARK: - event response
    func exitButtonClicked(sender:UIButton){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //MARK: - public method
    
    //MARK: - private method
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        self.tableView.backgroundColor = UIColor.mo_background()
        self.tableView.separatorStyle = .None
        
        
        exitButton.addTarget(self, action: #selector(exitButtonClicked(_:)), forControlEvents: .TouchUpInside)
        exitButton.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        exitButton.backgroundColor = UIColor.mo_main()
        exitButton.layer.cornerRadius = 3.0
        exitButton.layer.masksToBounds = true
    }
    
    
    //MARK: - var & let
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exitButton: UIButton!
    
    private let datas:[[String]] = [["常用地址","密码修改","账号绑定","音效开关","微信免支付"],
                                         ["用户指南"],
                                         ["关于应用","法律条款","用户反馈"]]
    
}

// MARK: - UITableView delegate
extension SettingController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.textLabel?.text = datas[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        

        switch (indexPath.section,indexPath.row) {
        case (0,2):
            self.performSegueWithIdentifier(SB.Setting.Segue.accountBinding, sender: nil)
        case (1,0):
            self.performSegueWithIdentifier(SB.Setting.Segue.userGuide, sender: nil)
        default:
            let vc = UIViewController()
            vc.title = datas[indexPath.section][indexPath.row]
            vc.view.backgroundColor = UIColor.mo_background()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableView datasource
extension SettingController: UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "settingCellIdentifier"
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else{
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        return cell
    }
}

