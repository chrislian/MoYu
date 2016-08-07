//
//  UseInfoController.swift
//  MoYu
//
//  Created by Chris on 16/7/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SwiftyJSON

class UseInfoController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人信息"
        
        self.setupView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onReceive(notify:)), name: UserNotification.updateUserInfo, object: nil)
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateUserInfo()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - event response
    
    func rightBarButtonClick(sender:UIButton){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        vc.title = "综合实力"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func onReceive(notify notify:NSNotification){
        
        if notify.name == UserNotification.updateUserInfo{
            self.updateUserInfo()
        }
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
    
    lazy var sexActionSheet:ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
   
    lazy var ageAlertController:UIAlertController = {
       let alert = UIAlertController(title: "修改年龄", message: "", preferredStyle: .Alert)
        
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { _ in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        let destrctiveAction = UIAlertAction(title: "确定", style: .Destructive) { _ in
            
            if let text = alert.textFields?.first?.text, age = Int(text){
                Router.updateAge(value: age).request( remote: self.updateUser )
            }
            
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addTextFieldWithConfigurationHandler { [unowned self ] textField in
            
            textField.font = UIFont.mo_font()
            textField.textColor = UIColor.mo_lightBlack()
            textField.text = "\(UserManager.sharedInstance.user.age)"
            textField.delegate = self
            textField.keyboardType = .NumberPad
        }
        alert.addAction(cancelAction)
        alert.addAction(destrctiveAction)
        return alert
    }()
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
        
        func update(cell cell:UITableViewCell){
            cell.textLabel?.font = UIFont.mo_font()
            cell.textLabel?.textColor = UIColor.mo_lightBlack()
            
            cell.detailTextLabel?.font = UIFont.mo_font()
            cell.detailTextLabel?.textColor = UIColor.mo_silver()
            
            cell.textLabel?.text = dataArrays[indexPath.section][indexPath.row].0
            cell.detailTextLabel?.text = dataArrays[indexPath.section][indexPath.row].1
        }
        
        cell.accessoryType = .DisclosureIndicator
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            if let cell = cell as? UserHeaderCell {
                let user = UserManager.sharedInstance.user
                cell.update(usename: user.moName,source:"手机登录",image: user.img)
            }
        case (0,4...5):
            cell.accessoryType = .None
            update(cell: cell)
        default:
            update(cell: cell)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch(indexPath.section,indexPath.row){
        case (0,0):
            let vc = ChangeNicknameController()
            vc.nickname = UserManager.sharedInstance.user.nickname
            self.navigationController?.pushViewController(vc, animated: true)
        case (0,1):
            let vc = AutoGraphController()
            vc.autograph = UserManager.sharedInstance.user.autograph
            self.navigationController?.pushViewController(vc, animated: true)
        case (0,2):
            sexActionSheet.show(self)
        case (0,3):
            self.presentViewController(ageAlertController, animated: true, completion: nil)
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

extension UseInfoController: ActionSheetProtocol{
    
    
    func otherButtons(sheet sheet: ActionSheetController) -> [String] {
        return ["女","男"]
    }
    
    func action(sheet sheet: ActionSheetController, selectedAtIndex: Int) {
        
        if UserManager.sharedInstance.user.sex == selectedAtIndex{
            return
        }
        
        Router.updateSex(value: selectedAtIndex).request(remote: self.updateUser )
    }
    
}

extension UseInfoController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > 2{
            textField.text = text.substringToIndex(2)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.stringByReplacingCharactersInRange(range, withString: string)
        if toBeString.characters.count > 2{
            textField.text = (toBeString as NSString).substringToIndex(2)
            return false
        }else if toBeString.mo_length() == 0{
            textField.text = "0"
        }
        
        return true
    }
}
