//
//  LeftMenuController.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class LeftMenuController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftMenuView()
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    @IBAction func settingButtonClicked(sender: UIButton) {
        
        guard let vc = SB.Setting.Vc.root() else{
            println("load setting vc failed")
            return
        }
        
        self.presentViewController(vc, animated: true, completion: nil)
        
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
    
    
    @IBOutlet var leftMenuView: LeftMenuView!
    
}

//MARK: - UITableView delegate
extension LeftMenuController: UITableViewDelegate{

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let moCell = cell as? LeftMenuCell else{
            return
        }
        
        moCell.updateCell(cellImages[indexPath.row], text: cellTitles[indexPath.row])
        moCell.selectionStyle = .None
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0{
            self.performSegueWithIdentifier(SB.Personal.Segue.myPurse, sender: nil)
        }
    }
}


//MARK: - UITableView datasource
extension LeftMenuController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(SB.Personal.Cell.leftMenuCell){
            return cell
        }
        
        return LeftMenuCell(style: .Default, reuseIdentifier: SB.Personal.Cell.leftMenuCell)
    }
}