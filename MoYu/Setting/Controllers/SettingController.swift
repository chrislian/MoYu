//
//  SettingController.swift
//  MoYu
//
//  Created by Chris on 16/7/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class SettingController: UIViewController,PraseErrorType, AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mo_navigationBar(title: "设置")
        
        navigationController?.mo_hideBackButtonTitle()
        
        navigationController?.mo_navigationBar(opaque: true)
        
        setupView()
    }

    
    //MARK: - event response
    func exitButtonClicked(_ sender:UIButton){
        
        Router.signOut.request { (status, json) in
            
            self.show(error: status, showSuccess: true)
            
            if case .success = status{
                
                UserManager.sharedInstance.deleteUser()
                self.showSignInView()
            }
        }
    }
    
    //MARK: - private method
    fileprivate func setupView(){
 
        
        mo_rootLeftBackButton()
        
        self.view.backgroundColor = UIColor.mo_background
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        self.tableView.backgroundColor = UIColor.mo_background
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        
        
        exitButton.addTarget(self, action: #selector(exitButtonClicked(_:)), for: .touchUpInside)
        exitButton.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
        exitButton.backgroundColor = UIColor.mo_main
        exitButton.layer.cornerRadius = 3.0
        exitButton.layer.masksToBounds = true
    }
    
    
    //MARK: - var & let
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exitButton: UIButton!
    
    fileprivate let datas:[[String]] = [["常用地址","密码修改","账号绑定","音效开关","微信免支付"],
                                         ["用户指南"],
                                         ["关于应用","法律条款","用户反馈"]]
}

// MARK: - UITableView delegate
extension SettingController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = datas[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        

        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,2):
            self.performSegue(withIdentifier: SB.Setting.Segue.accountBinding, sender: nil)
        case (1,0):
            self.performSegue(withIdentifier: SB.Setting.Segue.userGuide, sender: nil)
        case (2,1):
            self.performSegue(withIdentifier: SB.Setting.Segue.legalProvisions, sender: nil)
        case (2,2):
            let vc = FeedbackController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = UIViewController()
            vc.title = datas[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
            vc.view.backgroundColor = UIColor.mo_background
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableView datasource
extension SettingController: UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "settingCellIdentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else{
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        return cell
    }
}

