//
//  LeftMenuController.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Proposer

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
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.stopAnimating()
    }
    
    private func openPhotoLibrary(){
        let openCameraRoll: ProposerAction = { [weak self] in
            
            guard UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) else {
                self?.alertCanNotAccessCameraRoll()
                return
            }
            
            if let strongSelf = self {
                strongSelf.imagePicker.sourceType = .PhotoLibrary
                strongSelf.presentViewController(strongSelf.imagePicker, animated: true, completion: nil)
            }
        }
        
        proposeToAccess(.Photos, agreed: openCameraRoll, rejected: {
            self.alertCanNotAccessCameraRoll()
        })
    }
    
    private func openCameraRoll(){
        let openCamera: ProposerAction = { [weak self] in
            
            guard UIImagePickerController.isSourceTypeAvailable(.Camera) else {
                self?.alertCanNotOpenCamera()
                return
            }
            
            if let strongSelf = self {
                strongSelf.imagePicker.sourceType = .Camera
                strongSelf.presentViewController(strongSelf.imagePicker, animated: true, completion: nil)
            }
        }
        
        proposeToAccess(.Camera, agreed: openCamera, rejected: {
            self.alertCanNotOpenCamera()
        })
    }
    
    
    
    //MARK: - var & let
    let cellTitles = ["我的钱包","兼职管理","消息中心","推荐有奖","招募中心"]
    let cellImages = [UIImage(named: "leftMyPurse")!,
                      UIImage(named: "leftPartTimeManager")!,
                      UIImage(named: "leftMsgCenter")!,
                      UIImage(named: "leftAwardRecommend")!,
                      UIImage(named: "leftRecruitCenter")!]
    
    
    @IBOutlet var leftMenuView: LeftMenuView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    lazy var sourceActionSheet:ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        return imagePicker
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
    
    func action(sheet sheet: ActionSheetController, selectedAtIndex: Int) {
        
        if selectedAtIndex == 0{
            openCameraRoll()
        }else if selectedAtIndex == 1{
            openPhotoLibrary()
        }
    }
}


// MARK: UIImagePicker

extension LeftMenuController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        defer {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        let image = image.largestCenteredSquareImage().resizeToTargetSize(CGSize(width: 100, height: 100))
        
        guard let base64String = image.image2Base64() else{ return }
        
//        if let decodeImageData = NSData(base64EncodedString: base64String, options: .IgnoreUnknownCharacters),
//            let decodeImage = UIImage(data: decodeImageData){
//            
//            leftMenuView.update(avator: decodeImage)
//            println("imageSize:\(decodeImage.size)")
//        }        
        
        activityIndicatorView.startAnimating()
        
        Router.updateAvatar(string: base64String).request{
            self.updateUser($0, json: $1)
            self.activityIndicatorView.stopAnimating()
        }
    }
}

