//
//  FeedbackController.swift
//  MoYu
//
//  Created by Chris on 16/8/7.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText

class FeedbackController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.title = "用户反馈"
        
        self.setupView()
        
        
    }
    
    //MARK: - event reponse
    func typeButtonTap(button:UIButton){
        
        self.view.endEditing(true)
        
        typeActionSheet.show(self)
        
    }
    
    private func leftBarItemTap(){
        
        self.view.endEditing(true)
        
        guard let title = feedbackView.titleText.text where !title.isEmpty else{
            
            self.show(message: "标题不能为空")
            return
        }
        
        guard let content = feedbackView.contentText.text where !content.isEmpty else{
            self.show(message: "内容不能为空")
            return
        }
        
        Router.feedback(type: String(selectIndex + 1), title: title, content: content).request { (status, json) in
            self.show(error: status)
            
            if case .success = status{
                self.navigationController?.popViewControllerAnimated( true )
            }
        }
    }
    
    //MARK: - private method
    private func setupView(){
        
        let attribute = NSAttributedString(string: "提交", attributes: [NSFontAttributeName:UIFont.mo_font(), NSForegroundColorAttributeName : UIColor.mo_lightBlack() ] )
        self.setRightNavigationButton(attributedString: attribute)
        self.rightButtonClourse = { [unowned  self] in
            self.leftBarItemTap()
        }
        
        
        self.view.addSubview(feedbackView)
        feedbackView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        feedbackView.backgroundColor = UIColor.mo_background()
        
        feedbackView.contentText.delegate = self
        feedbackView.titleText.delegate = self
        feedbackView.typeButton.addTarget(self, action: #selector(typeButtonTap(_:)), forControlEvents: .TouchUpInside)
        feedbackView.typeButton.setTitle(feedbackTypes[0], forState: .Normal)
    }
    
    
    private let feedbackView = FeedbackView()
    
    private let feedbackTypes = ["广告合作", "开发建议"]
    private var selectIndex = 0
    
    lazy var typeActionSheet: ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
}

extension FeedbackController: YYTextViewDelegate{
    
    func textViewDidEndEditing(textView: YYTextView) {
        
    }
    
    func textView(textView: YYTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        func handleContentView()-> Bool {
            let maxLength = 500
            let string = (textView.text)! as NSString
            let toBeString = string.stringByReplacingCharactersInRange(range, withString: text)
            
            feedbackView.countDownLabel.text = "\(toBeString.length)/\(maxLength)"
            
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substringToIndex(maxLength)
                return false
            }
            return true
        }
        
        func handleTitleView()->Bool{
            let maxLength = 40
            let string = (textView.text)! as NSString
            let toBeString = string.stringByReplacingCharactersInRange(range, withString: text)
            if toBeString.characters.count > maxLength{
                textView.text = (toBeString as NSString).substringToIndex(maxLength)
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
    
    func otherButtons(sheet sheet: ActionSheetController) -> [String] {
        
        return feedbackTypes
    }
    
    func action(sheet sheet: ActionSheetController, selectedAtIndex: Int) {
        
        feedbackView.typeButton.setTitle(feedbackTypes[selectedAtIndex], forState: .Normal)
        
        selectIndex = selectedAtIndex
    }
}
