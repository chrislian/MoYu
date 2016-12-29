//
//  UserGuideController.swift
//  MoYu
//
//  Created by Chris on 16/7/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class UserGuideController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mo_navigationBar(title: "用户指南")
        
        self.setupView()
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background
        
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        self.tableView.backgroundColor = UIColor.mo_background
        
    }

    //MARK: - let & var
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let datas = ["商家指南","任务指南","积分规则"]
}

// MARK: - UITableView Delegate
extension UserGuideController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.textLabel?.text = datas[(indexPath as NSIndexPath).row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UIViewController()
        vc.title = datas[(indexPath as NSIndexPath).row]
        vc.view.backgroundColor = UIColor.mo_background
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableView datasource
extension UserGuideController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "userGuideIndentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else{
            
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        return cell
    }
}
