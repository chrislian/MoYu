//
//  CommentController.swift
//  MoYu
//
//  Created by lxb on 2016/12/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import PHFComposeBarView
import PHFDelegateChain


class CommentController: UIViewController,AlertViewType,PraseErrorType {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "评论"
        self.view.backgroundColor = UIColor.mo_background()
    
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillToggle(notify:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil )
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillToggle(notify:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        IQKeyboardManager.sharedManager().enable = false
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.sharedManager().enable = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - event reponse
    @objc private func keyboardWillToggle(notify:Notification){
    
        guard let userInfo = notify.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let startFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let heightChange = (endFrame.origin.y - startFrame.origin.y)
        UIView.animate(withDuration: duration) { 
            self.composeBarView.frame.origin.y += heightChange
        }
    }
    
    
    //MARK: - private methods
    private func setupView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.mo_background()
        tableView.tableFooterView = UIView()
        
        view.addSubview(composeBarView)
    }
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    
    lazy var composeBarView:PHFComposeBarView = {
        
        let frame = CGRect(x: 0, y: MoScreenHeight - PHFComposeBarViewInitialHeight, width: MoScreenWidth, height: PHFComposeBarViewInitialHeight)
        let view = PHFComposeBarView(frame:frame)
        view.maxCharCount = 200
        view.maxLinesCount = 5
        view.placeholder = "说点什么吧~"
        view.utilityButtonImage = UIImage(named: "icon_picture")
        view.buttonTitle = "发送"
        view.delegate = self
        return view
    }()
    
    var aboutJobModel:AboutJobItem?
}

extension CommentController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let model = aboutJobModel else{ return }
        
        if let cell = cell as? CommentTopCell{
            cell.update(comments: model.memo, count: model.replylists.count)
        
        }else if let cell = cell as? CommentSubCell{
            cell.update(model: model.replylists[indexPath.row], index: indexPath.row + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CommentController: UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            return 1
        }
        return aboutJobModel?.replylists.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            return CommentTopCell.cell(tableView: tableView)
        default:
            return CommentSubCell.cell(tableView: tableView)
        }
    }
    
}

extension CommentController: PHFComposeBarViewDelegate{
    
    func composeBarViewDidPressButton(_ composeBarView: PHFComposeBarView!) {
        if let text = composeBarView.text{
            println("main button press: \(text)")
            composeBarView.setText("", animated: true)
            composeBarView.resignFirstResponder()
        }
    }
    
    func composeBarViewDidPressUtilityButton(_ composeBarView: PHFComposeBarView!) {
        
//        showAlert(message: "还不支持图片恢复哦~")
    }
    
}
