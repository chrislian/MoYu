//
//  AccountBindingController
//  MoYu
//
//  Created by Chris on 16/7/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AccountBindingController: UIViewController {

    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        mo_navigationBar(title: "站好绑定")
        
    }
    
    //MARK: - event response
    
    //MARK: - public method
    
    //MARK: - private method
    private func setupView(){
        
        self.tableView.rowHeight = 44
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
    }

    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    private lazy var accountingModel = MOAccountBindingModel()
}

// MARK: - UITableView Delegate
extension AccountBindingController:UITableViewDelegate{

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let accountCell = cell as? AccountBindingCell else{ return }
        
        accountCell.selectionStyle = .None
        accountCell.update(acount: accountingModel.accounts[indexPath.row])
        accountCell.bindingButtonClick = {
            println("binding Button clicked: type:\($0)")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// MARK: - UITableView datasource
extension AccountBindingController:UITableViewDataSource{
    
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
