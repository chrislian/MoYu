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
        
        mo_navigationBar(title: "账号绑定")
        
    }
    
    //MARK: - event response
    
    //MARK: - public method
    
    //MARK: - private method
    fileprivate func setupView(){
        
        self.tableView.rowHeight = 44
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }

    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var accountingModel = MOAccountBindingModel()
}

// MARK: - UITableView Delegate
extension AccountBindingController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let accountCell = cell as? AccountBindingCell else{ return }
        
        accountCell.selectionStyle = .none
        accountCell.update(acount: accountingModel.accounts[(indexPath as NSIndexPath).row])
        accountCell.bindingButtonClick = {
            println("binding Button clicked: type:\($0)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableView datasource
extension AccountBindingController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountingModel.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Personal.Cell.accountBindingCell) else{
            return UITableViewCell(style: .default, reuseIdentifier: SB.Personal.Cell.accountBindingCell)
        }
        return cell
    }
}
