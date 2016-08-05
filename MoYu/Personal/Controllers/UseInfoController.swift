//
//  UseInfoController.swift
//  MoYu
//
//  Created by Chris on 16/7/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class UseInfoController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人信息"
        
        self.setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateUserInfo()
    }
    
    //MARK: - event response
    
    func rightBarButtonClick(sender:UIButton){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        vc.title = "综合实力"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    //MARK: - private method
    private func setupView(){

        self.addBackNavigationButton()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "综合实力", style: .Done, target:self, action: #selector(rightBarButtonClick(_:)))
        
        self.view.backgroundColor = UIColor.mo_background()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.mo_background()
    }
    
    private func updateUserInfo(){
        
        let user = UserManager.sharedInstance.user
        
        let array1 = [("昵称",user.moName),
                      ("我的签名",user.moAutograph),
                      ("性别",user.moSex),
                      ("年龄","\(user.age)"),
                      ("手机号码",user.moPhone),
                      ("我的等级",user.moLevel)]
        
        let array2 = [("学校",""), ("课余时间",""), ("实名认证",""), ("商家认证","")]
        
        dataArrays = [array1,array2]
        
        self.tableView.reloadData()
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    var dataArrays:[[(String,String)]] = [[]]
}

extension UseInfoController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0{
            return 80.0
        }
        return 44.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.accessoryType = .DisclosureIndicator
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            if let cell = cell as? UserHeaderCell {
                let user = UserManager.sharedInstance.user
                cell.update(usename: user.moName,source:"手机登录",image: user.img)
            }
        default:
            cell.textLabel?.font = UIFont.mo_font()
            cell.textLabel?.textColor = UIColor.mo_lightBlack()
            
            cell.detailTextLabel?.font = UIFont.mo_font()
            cell.detailTextLabel?.textColor = UIColor.mo_silver()
            
            cell.textLabel?.text = dataArrays[indexPath.section][indexPath.row].0
            cell.detailTextLabel?.text = dataArrays[indexPath.section][indexPath.row].1
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch(indexPath.section,indexPath.row){
        case (0,0):
            let vc = ChangeNicknameController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.mo_background()
            vc.title = dataArrays[indexPath.section][indexPath.row].0
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
}

extension UseInfoController:UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArrays.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrays[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        func cellForHeader()->UITableViewCell{
            guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Personal.Cell.userHeaderCell) else{
                return UITableViewCell(style: .Default, reuseIdentifier: SB.Personal.Cell.userHeaderCell)
            }
            return cell
        }
        
        func cellForOther()->UITableViewCell{
            let cellIdentifier = "userInfoCellIdentifier"
            guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else{
                return UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
            }
            return cell
        }
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            return cellForHeader()
        default:
            return cellForOther()
        }
    }
}
