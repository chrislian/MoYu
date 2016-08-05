//
//  MyPurseController.swift
//  MoYu
//
//  Created by Chris on 16/7/23.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


private enum MyPurseType{
    case Balance(amount:Float)
    case Recharge,Withdraw
    
    func image()->UIImage?{
        switch self {
        case .Balance:
            return UIImage(named: "myPurseBalance")
        case .Recharge:
            return UIImage(named: "myPurseRecharge")
        case .Withdraw:
            return UIImage(named: "myPurseWithdraw")
        }
    }
    
    func title()->String{
        switch self{
        case .Balance:
            return "余额"
        case .Recharge:
            return "提现"
        case .Withdraw:
            return "充值"
        }
    }
    
}

class MyPurseController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的钱包"
        
        self.setupView()
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.addBackNavigationButton()

        tableView.separatorStyle = .None
        
        tableView.backgroundColor = UIColor.mo_background()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 44
    }
    
    private func setupCells(balance amount:Float = 0)->[MyPurseType]{
        
        var cellItems = [MyPurseType]()
        cellItems.append(.Balance(amount: amount))
        cellItems.append(.Withdraw)
        cellItems.append(.Recharge)
        
        return cellItems
    }
    

    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var cellItems:[MyPurseType] = self.setupCells()
    
}

extension MyPurseController: UITableViewDelegate{

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        

        switch cellItems[indexPath.row] {
        case .Balance(_):
            let vc = BalanceController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let title = cellItems[indexPath.row].title()
            let vc = UIViewController()
            vc.title = title
            vc.view.backgroundColor = UIColor.mo_mercury()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MyPurseController: UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var balance = ""
        let image = cellItems[indexPath.row].image()
        let title = cellItems[indexPath.row].title()
        
        let cell = MyPurseCell.cell(tableView)
        cell.accessoryType = .DisclosureIndicator
        
        switch cellItems[indexPath.row] {
        case .Balance(let amount):
            balance = String(format: "%.2f",amount) + "元"
        default:break
        }
        
        cell.update(icon: image, leftText: title, rightText: balance)
        
        return cell
    }
    
}
