//
//  MOUserGuideViewController.swift
//  MoYu
//
//  Created by Chris on 16/7/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOUserGuideViewController: MOBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "用户指南"
        
        self.setupView()
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        self.tableView.backgroundColor = UIColor.mo_background()
        
    }

    //MARK: - let & var
    @IBOutlet weak var tableView: UITableView!
    
    private let datas = ["商家指南","任务指南","积分规则"]
}

// MARK: - UITableView Delegate
extension MOUserGuideViewController:UITableViewDelegate{

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = UIViewController()
        vc.title = datas[indexPath.row]
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableView datasource
extension MOUserGuideViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "userGuideIndentifier"
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else{
            
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        return cell
    }
}