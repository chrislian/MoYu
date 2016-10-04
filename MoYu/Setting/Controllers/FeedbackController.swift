//
//  FeedbackController.swift
//  MoYu
//
//  Created by Chris on 16/8/7.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText

class FeedbackController: UIViewController,PraseErrorType,AlertViewType {

    override func viewDidLoad() {
        super.viewDidLoad()

       mo_navigationBar(title: "用户反馈")
        
        self.setupView()
        
        
    }
    
    //MARK: - event reponse
    func typeButtonTap(_ button:UIButton){
        
        self.view.endEditing(true)
        
        typeActionSheet.show(self)
        
    }
    
    @objc fileprivate func rightBarItem(tap sender:AnyObject){
        
        self.view.endEditing(true)
        
        guard let title = feedbackView.titleText.text , !title.isEmpty else{
            
            self.showAlert(message: "标题不能为空")
            return
        }
        
        guard let content = feedbackView.contentText.text , !content.isEmpty else{
            self.showAlert(message: "内容不能为空")
            return
        }
        
        Router.feedback(type: String(selectIndex + 1), title: title, content: content).request { (status, json) in
            self.show(error: status)
            
            if case .success = status{
                let _ = self.navigationController?.popViewController( animated: true )
            }
        }
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        let rightBarButton = UIBarButtonItem(title: "提交", style: .plain, target: self, action: #selector(rightBarItem(tap:)))
        navigationItem.rightBarButtonItem = rightBarButton
        
        
        self.view.addSubview(feedbackView)
        feedbackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        feedbackView.backgroundColor = UIColor.mo_background()
        
        feedbackView.contentText.delegate = self
        feedbackView.titleText.delegate = self
        feedbackView.typeButton.addTarget(self, action: #selector(typeButtonTap(_:)), for: .touchUpInside)
        feedbackView.typeButton.setTitle(feedbackTypes[0], for: UIControlState())
    }
    
    
    fileprivate let feedbackView = FeedbackView()
    
    fileprivate let feedbackTypes = ["广告合作", "开发建议"]
    fileprivate var selectIndex = 0
    
    lazy var typeActionSheet: ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
}

extension FeedbackController: YYTextViewDelegate{
    
    func textViewDidEndEditing(_ textView: YYTextView) {
        
    }
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        func handleContentView()-> Bool {
            let maxLength = 500
            let string = (textView.text)! as NSString
            let toBeString = string.replacingCharacters(in: range, with: text)
            
            feedbackView.countDownLabel.text = "\(toBeString.length)/\(maxLength)"
            
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substring(to: maxLength)
                return false
            }
            return true
        }
        
        func handleTitleView()->Bool{
            let maxLength = 40
            let string = (textView.text)! as NSString
            let toBeString = string.replacingCharacters(in: range, with: text)
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substring(to: maxLength)
                return false
            }
            return true
        }
        
        if textView === feedbackView.titleText{
            return handleTitleView()
        }else{
            return handleContentView()
        }
    }
}

extension FeedbackController : ActionSheetProtocol{
    
    func otherButtons(sheet: ActionSheetController) -> [String] {
        
        return feedbackTypes
    }
    
    func action(sheet: ActionSheetController, selectedAtIndex: Int) {
        
        feedbackView.typeButton.setTitle(feedbackTypes[selectedAtIndex], for: UIControlState())
        
        selectIndex = selectedAtIndex
    }
}
