//
//  MOLeftMenuViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOLeftMenuViewController: MOBaseViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftMenuView()
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    //MARK: - private method
    private func setupLeftMenuView(){
        leftMenuView.tableView.delegate = self
        leftMenuView.tableView.dataSource = self
        
        leftMenuView.updateUserHead(UIImage(named: "defalutHead")!, username: "墨鱼", phone: "18350210050")
        leftMenuView.isCustomerAuth = true
    }
    
    //MARK: - var & let
    let cellTitles = ["我的钱包","兼职管理","消息中心","推荐有奖","招募中心"]
    let cellImages = [UIImage(named: "leftMyPurse")!,
                      UIImage(named: "leftPartTimeManager")!,
                      UIImage(named: "leftMsgCenter")!,
                      UIImage(named: "leftAwardRecommend")!,
                      UIImage(named: "leftRecruitCenter")!]
    
    
    @IBOutlet var leftMenuView: MOLeftMenuView!
    
}

//MARK: - UITableView delegate
extension MOLeftMenuViewController: UITableViewDelegate{

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let moCell = cell as? MOLeftTableViewCell else{
            return
        }
        
        moCell.updateCell(cellImages[indexPath.row], text: cellTitles[indexPath.row])
        moCell.selectionStyle = .None
    }
}

//MARK: - UITableView datasource
extension MOLeftMenuViewController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(SB.Left.Cell.leftMenuCell){
            return cell
        }
        
        return MOLeftTableViewCell(style: .Default, reuseIdentifier: SB.Left.Cell.leftMenuCell)
    }
}