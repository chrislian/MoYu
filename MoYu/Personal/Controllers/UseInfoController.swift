//
//  UseInfoController.swift
//  MoYu
//
//  Created by Chris on 16/7/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SwiftyJSON

class UseInfoController: UIViewController ,PraseErrorType, AlertViewType{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mo_navigationBar(title: "个人信息")
        
        self.setupView()
        
        NotificationCenter.add(observer: self, selector: #selector(onReceive(notify:)), name: MoNotification.updateUserInfo)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateUserInfo()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - event response
    
    func rightBarItem(tap sender:AnyObject){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        vc.title = "综合实力"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func onReceive(notify:Notification){
        
        if notify.name == MoNotification.updateUserInfo{
            self.updateUserInfo()
        }
    }
    
    
    //MARK: - private method
    fileprivate func setupView(){

        navigationController?.mo_hideBackButtonTitle()
        navigationController?.mo_navigationBar(opaque: true)
        
        mo_rootLeftBackButton()

        let rightBarButton = UIBarButtonItem(title: "综合实力", style: .plain, target: self, action: #selector(rightBarItem(tap:)))
        navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.backgroundColor = UIColor.mo_background()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.mo_background()
    }
    
    fileprivate func updateUserInfo(){
        
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
       let alert = UIAlertController(title: "修改年龄", message: "", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        let destrctiveAction = UIAlertAction(title: "确定", style: .destructive) { _ in
            
            if let text = alert.textFields?.first?.text, let age = Int(text){
                Router.updateAge(value: age).request( remote: self.updateUser )
            }
            
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { [unowned self ] textField in
            
            textField.font = UIFont.mo_font()
            textField.textColor = UIColor.mo_lightBlack()
            textField.text = "\(UserManager.sharedInstance.user.age)"
            textField.delegate = self
            textField.keyboardType = .numberPad
        }
        alert.addAction(cancelAction)
        alert.addAction(destrctiveAction)
        return alert
    }()
}

extension UseInfoController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row == 0 && (indexPath as NSIndexPath).section == 0{
            return 80.0
        }
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        func update(cell:UITableViewCell){
            cell.textLabel?.font = UIFont.mo_font()
            cell.textLabel?.textColor = UIColor.mo_lightBlack()
            
            cell.detailTextLabel?.font = UIFont.mo_font()
            cell.detailTextLabel?.textColor = UIColor.mo_silver()
            
            cell.textLabel?.text = dataArrays[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row].0
            cell.detailTextLabel?.text = dataArrays[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row].1
        }
        
        cell.accessoryType = .disclosureIndicator
        
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            if let cell = cell as? UserHeaderCell {
                let user = UserManager.sharedInstance.user
                cell.update(usename: user.moName,source:"手机登录",image: user.img)
            }
        case (0,4...5):
            cell.accessoryType = .none
            update(cell: cell)
        default:
            update(cell: cell)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row){
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
            self.present(ageAlertController, animated: true, completion: nil)
        default:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.mo_background()
            vc.title = dataArrays[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row].0
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
}

extension UseInfoController:UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArrays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrays[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func cellForHeader()->UITableViewCell{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Personal.Cell.userHeaderCell) else{
                return UITableViewCell(style: .default, reuseIdentifier: SB.Personal.Cell.userHeaderCell)
            }
            return cell
        }
        
        func cellForOther()->UITableViewCell{
            let cellIdentifier = "userInfoCellIdentifier"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else{
                return UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
            }
            return cell
        }
        
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            return cellForHeader()
        default:
            return cellForOther()
        }
    }
}

extension UseInfoController: ActionSheetProtocol{
    
    
    func otherButtons(sheet: ActionSheetController) -> [String] {
        return ["女","男"]
    }
    
    func action(sheet: ActionSheetController, selectedAtIndex: Int) {
        
        if UserManager.sharedInstance.user.sex == selectedAtIndex{
            return
        }
        
        Router.updateSex(value: selectedAtIndex).request(remote: self.updateUser )
    }
    
}

extension UseInfoController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let text = (textField.text)! as NSString
        if text.length > 2{
            textField.text = text.substring(to: 2)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text)! as NSString
        let toBeString = text.replacingCharacters(in: range, with: string)
        if toBeString.characters.count > 2{
            textField.text = (toBeString as NSString).substring(to: 2)
            return false
        }else if toBeString.mo_length() == 0{
            textField.text = "0"
        }
        
        return true
    }
}
