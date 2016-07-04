//
//  MOAccountBindingViewController.swift
//  MoYu
//
//  Created by Chris on 16/7/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOAccountBindingViewController: MOBaseViewController {

    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        self.title = "账号绑定"
        
    }
    
    //MARK: - event response
    
    //MARK: - public method
    
    //MARK: - private method
    private func setupView(){
        
        self.tableView.rowHeight = 44
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    private lazy var accountingModel = MOAccountBindingModel()
}

// MARK: - UITableView Delegate
extension MOAccountBindingViewController:UITableViewDelegate{

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let accountCell = cell as? MOAccountBindingCell else{ return }
        
        accountCell.selectionStyle = .None
        accountCell.update(acount: accountingModel.accounts[indexPath.row])
        accountCell.bindingButtonClick = {
            MOLog("binding Button clicked: type:\($0)")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// MARK: - UITableView datasource
extension MOAccountBindingViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountingModel.accounts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Personal.Cell.accountBindingCell) else{
            return UITableViewCell(style: .Default, reuseIdentifier: SB.Personal.Cell.accountBindingCell)
        }
        return cell
    }
}
