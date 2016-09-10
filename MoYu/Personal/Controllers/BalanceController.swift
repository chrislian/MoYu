//
//  BalanceController.swift
//  MoYu
//
//  Created by Chris on 16/7/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class BalanceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        mo_navigationBar(title: "财务信息")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.mo_navigationBar(opaque: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.mo_navigationBar(opaque: true)
    }
    
    
    
    //MARK: - private method
    private func setupView(){
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview( tableView )
 
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        tableView.contentInset = UIEdgeInsets(top: headerDefaultHeight, left: 0, bottom: 0, right: 0)
        
        tableView.addSubview( self.balanceHeadView )
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(-64)
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
    
    private let headerDefaultHeight:CGFloat = 280
    private lazy var balanceHeadView: BalanceHeadView = {
        let view = BalanceHeadView(frame:CGRect(x: 0, y: -self.headerDefaultHeight, width: self.view.bounds.width, height: self.headerDefaultHeight))
        return view
    }()
}

extension BalanceController : UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
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


//MARK: - UIScrollView
extension BalanceController{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y + 64
        if y < -headerDefaultHeight {
            var frame = balanceHeadView.frame
            frame.origin.y = y
            frame.size.height = -y
            balanceHeadView.frame = frame
        }
        
        //切换透明背景
        if y - 2 > -headerDefaultHeight {
            navigationController?.mo_navigationBar(opaque: true)
        } else {
            navigationController?.mo_navigationBar(opaque: false)
        }
    }
}

