//
//  PublishTaskCell.swift
//  MoYu
//
//  Created by Chris on 16/8/31.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText

class PublishTaskCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public method
    static func cell(tableView tableView:UITableView) -> PublishTaskCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(String(PublishTaskCell)) as? PublishTaskCell else{
            return PublishTaskCell(style: .Default, reuseIdentifier: String(PublishTaskCell))
        }
        return cell
    }
    
    func update(placeholder:String, maxLength:Int, clourse:(String->Void)){
        inputTextView.placeholderText = placeholder
        self.maxLength = maxLength
        self.endClourse = clourse
    }
    
    
    //MARK: - private method
    private func setupCell(){
        
        self.contentView.addSubview(inputTextView)
        inputTextView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
 
    //MARK: - var & let 
    
    private var maxLength = 0
    
    private lazy var inputTextView:YYTextView = {
        
        let textView = YYTextView()
        textView.placeholderFont = UIFont.mo_font()
        textView.placeholderTextColor = UIColor.mo_silver()
        textView.font = UIFont.mo_font()
        textView.textColor = UIColor.mo_lightBlack()
        textView.delegate = self
        return textView
    }()
    
    private var endClourse:(String->Void)?

}

extension PublishTaskCell: YYTextViewDelegate{
    
    func textViewDidEndEditing(textView: YYTextView) {
        
        endClourse?(textView.text)
    }
    
    func textViewShouldEndEditing(textView: YYTextView) -> Bool {
        
        return true
    }
    
    func textView(textView: YYTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let string = (textView.text)! as NSString
        let toBeString = string.stringByReplacingCharactersInRange(range, withString: text)
        if toBeString.characters.count > maxLength && maxLength > 0{
            textView.text = (toBeString as NSString).substringToIndex(maxLength)
            return false
        }
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
