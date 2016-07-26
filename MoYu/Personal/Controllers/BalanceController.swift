//
//  BalanceController.swift
//  MoYu
//
//  Created by Chris on 16/7/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class BalanceController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        self.title = "财务信息"
    }
    
    
    //MARK: - private method
    private func setupView(){
        
        self.view.addSubview( tableView )
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: - var & let
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.rowHeight = 55.0
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = .None
        return tableView
    }()
    
    
    private lazy var cellItems: [ConsumeHistoryItem] = {
        var items:[ConsumeHistoryItem] = []
        for i in 0..<10{
            items.append( ConsumeHistoryItem())
        }
        return items
    }()
    
}

extension BalanceController : UITableViewDelegate{
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = cell as? BalanceCell else{
            return
        }
        
        cell.update( cellItems[indexPath.row] )
    }
}

extension BalanceController : UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = BalanceCell.cell(tableView: tableView)
        cell.selectionStyle = .None
        return cell
    }
}
