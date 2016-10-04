//
//  MyPurseController.swift
//  MoYu
//
//  Created by Chris on 16/7/23.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


private enum MyPurseType{
    case balance(amount:Float)
    case recharge,withdraw
    
    func image()->UIImage?{
        switch self {
        case .balance:
            return UIImage(named: "myPurseBalance")
        case .recharge:
            return UIImage(named: "myPurseRecharge")
        case .withdraw:
            return UIImage(named: "myPurseWithdraw")
        }
    }
    
    func title()->String{
        switch self{
        case .balance:
            return "余额"
        case .recharge:
            return "提现"
        case .withdraw:
            return "充值"
        }
    }
    
}

class MyPurseController: UIViewController, PraseErrorType, AlertViewType {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的钱包"
        
        self.setupView()
        
        
        Router.financial.request { (status, json) in
            self.show(error: status)
        }
    }
    
    //MARK: - event response
    @objc fileprivate func backButton(tap sender:AnyObject){
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        mo_rootLeftBackButton()

        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.mo_background()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 44
    }
    
    fileprivate func setupCells(balance amount:Float = 0)->[MyPurseType]{
        
        var cellItems = [MyPurseType]()
        cellItems.append(.balance(amount: amount))
        cellItems.append(.withdraw)
        cellItems.append(.recharge)
        
        return cellItems
    }
    

    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var cellItems:[MyPurseType] = self.setupCells()
}

extension MyPurseController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        

        switch cellItems[(indexPath as NSIndexPath).row] {
        case .balance(_):
            let vc = BalanceController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let title = cellItems[(indexPath as NSIndexPath).row].title()
            let vc = UIViewController()
            vc.title = title
            vc.view.backgroundColor = UIColor.mo_mercury()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MyPurseController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var balance = ""
        let image = cellItems[(indexPath as NSIndexPath).row].image()
        let title = cellItems[(indexPath as NSIndexPath).row].title()
        
        let cell = MyPurseCell.cell(tableView)
        cell.accessoryType = .disclosureIndicator
        
        switch cellItems[(indexPath as NSIndexPath).row] {
        case .balance(let amount):
            balance = String(format: "%.2f",amount) + "元"
        default:break
        }
        
        cell.update(icon: image, leftText: title, rightText: balance)
        
        return cell
    }
    
}
