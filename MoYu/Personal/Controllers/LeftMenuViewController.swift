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
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onReceive(notify:)), name: UserNotification.updateUserInfo, object: nil)
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
    }
    
    //MARK: - event response
    
    @objc private func onReceive(notify sender:NSNotification){
        
        if sender.name == UserNotification.updateUserInfo{
            
            leftMenuView.updateHeader(user: UserManager.sharedInstance.user)
        }
    }
    
    /**
     个人信息
     
     - parameter sender:
     */
    @IBAction func headerTap(sender: UITapGestureRecognizer) {
        
        self.performSegueWithIdentifier(SB.Personal.Segue.userInfo, sender: nil)
        
    }
    
    /**
     更改头像
     
     - parameter sender:
     */
    @IBAction func headerImageTap(sender: UITapGestureRecognizer) {
        
        self.sourceActionSheet.show( self )
    }
    
    /**
     设置按钮
     
     - parameter sender:
     */
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
        
        leftMenuView.updateHeader(user: UserManager.sharedInstance.user)
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
    
    
    lazy var sourceActionSheet:ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
    
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
        return cellTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(SB.Personal.Cell.leftMenuCell){
            return cell
        }
        
        return LeftMenuCell(style: .Default, reuseIdentifier: SB.Personal.Cell.leftMenuCell)
    }
}


extension LeftMenuController: ActionSheetProtocol{
    
    
    func otherButtons(sheet sheet: ActionSheetController) -> [String] {
        return ["拍照","从手机相册选择"]
    }
    
    func action(sheet sheet: ActionSheetController, selectedAtIndex: UInt) {
        
        if selectedAtIndex == 0{
            println("拍照")
        }else if selectedAtIndex == 1{
            println("从手机相册选择")
        }
    }
    
}
