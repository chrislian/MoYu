//
//  LeftMenuController.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Proposer

class LeftMenuController: UIViewController,SignInType,PraseErrorType,AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftMenuView()
        
        NotificationCenter.add(observer: self, selector: #selector(onReceive(notify:)), name: MoNotification.updateUserInfo)
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - event response
    
    @objc fileprivate func onReceive(notify sender:Notification){
        
        if sender.name == MoNotification.updateUserInfo{
            
            leftMenuView.updateHeader(user: UserManager.sharedInstance.user)
        }
    }
    
    /**
     个人信息
     
     - parameter sender:
     */
    @IBAction func headerTap(_ sender: UITapGestureRecognizer) {
        
        if !UserManager.sharedInstance.isLoginIn{
            self.showSignInView()
            return
        }
        
        self.performSegue(withIdentifier: SB.Personal.Segue.userInfo, sender: nil)
        
    }
    
    /**
     更改头像
     
     - parameter sender:
     */
    @IBAction func headerImageTap(_ sender: UITapGestureRecognizer) {
        
        if !UserManager.sharedInstance.isLoginIn{
            self.showSignInView()
            return
        }
        
        self.sourceActionSheet.show( self )
    }
    
    /**
     设置按钮
     
     - parameter sender:
     */
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        
        if !UserManager.sharedInstance.isLoginIn{
            self.showSignInView()
            return
        }
        
        guard let vc = SB.Setting.root else{
            println("load setting vc failed")
            return
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    //MARK: - private method
    fileprivate func setupLeftMenuView(){
        leftMenuView.tableView.delegate = self
        leftMenuView.tableView.dataSource = self
        
        leftMenuView.updateHeader(user: UserManager.sharedInstance.user)
        leftMenuView.isCustomerAuth = true
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.stopAnimating()
    }
    
    fileprivate func openPhotoLibrary(){
        let openCameraRoll: ProposerAction = { [weak self] in
            
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                self?.alertCanNotAccessCameraRoll()
                return
            }
            
            if let strongSelf = self {
                strongSelf.imagePicker.sourceType = .photoLibrary
                strongSelf.present(strongSelf.imagePicker, animated: true, completion: nil)
            }
        }
        
        proposeToAccess(.photos, agreed: openCameraRoll, rejected: {
            self.alertCanNotAccessCameraRoll()
        })
    }
    
    fileprivate func openCameraRoll(){
        let openCamera: ProposerAction = { [weak self] in
            
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                self?.alertCanNotOpenCamera()
                return
            }
            
            if let strongSelf = self {
                strongSelf.imagePicker.sourceType = .camera
                strongSelf.present(strongSelf.imagePicker, animated: true, completion: nil)
            }
        }
        
        proposeToAccess(.camera, agreed: openCamera, rejected: {
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
    
    fileprivate lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        return imagePicker
    }()
}

//MARK: - UITableView delegate
extension LeftMenuController: UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let moCell = cell as? LeftMenuCell else{
            return
        }
        
        moCell.updateCell(cellImages[(indexPath as NSIndexPath).row], text: cellTitles[(indexPath as NSIndexPath).row])
        moCell.selectionStyle = .none
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if !UserManager.sharedInstance.isLoginIn{
            self.showSignInView()
            return
        }
        
        switch (indexPath as NSIndexPath).row{
        case 0:
            self.performSegue(withIdentifier: SB.Personal.Segue.myPurse, sender: nil)
        case 1:
            self.performSegue(withIdentifier: SB.Personal.Segue.parttimeJob, sender: nil)
        case 2:
            self.performSegue(withIdentifier: SB.Personal.Segue.messageCenter, sender: nil)
        case 3:
            self.performSegue(withIdentifier: SB.Personal.Segue.recommend, sender: nil)
        case 4:
            self.performSegue(withIdentifier: SB.Personal.Segue.recuritCenter, sender: nil)
        default :break
        }
        
    }
}


//MARK: - UITableView datasource
extension LeftMenuController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SB.Personal.Cell.leftMenuCell){
            return cell
        }
        
        return LeftMenuCell(style: .default, reuseIdentifier: SB.Personal.Cell.leftMenuCell)
    }
}


extension LeftMenuController: ActionSheetProtocol{
    
    
    func otherButtons(sheet: ActionSheetController) -> [String] {
        return ["拍照","从手机相册选择"]
    }
    
    func action(sheet: ActionSheetController, selectedAtIndex: Int) {
        
        if selectedAtIndex == 0{
            openCameraRoll()
        }else if selectedAtIndex == 1{
            openPhotoLibrary()
        }
    }
}


// MARK: UIImagePicker

extension LeftMenuController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
        defer {
            dismiss(animated: true, completion: nil)
        }
        
        let image = image.largestCenteredSquareImage().resizeToTargetSize(CGSize(width: 100, height: 100))
        
        guard let base64String = image.image2Base64() else{ return }
        
        activityIndicatorView.startAnimating()
        
        Router.updateAvatar(string: base64String).request{
            self.updateUser($0, json: $1)
            self.activityIndicatorView.stopAnimating()
            NotificationCenter.post(name:MoNotification.updateUserInfo)
        }
    }
}

