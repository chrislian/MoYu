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


class CommentController: UIViewController {

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
}

extension CommentController:UITableViewDelegate{

}

extension CommentController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            return CommentTopCell.cell(tableView: tableView)
        default:
            return UITableViewCell()
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
        
        println("Utility button pressed")
    }
    
}
