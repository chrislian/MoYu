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
    static func cell(tableView:UITableView) -> PublishTaskCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PublishTaskCell.self)) as? PublishTaskCell else{
            return PublishTaskCell(style: .default, reuseIdentifier: String(describing: PublishTaskCell.self))
        }
        return cell
    }
    
    func update(_ placeholder:String, maxLength:Int, clourse:@escaping ((String)->Void)){
        inputTextView.placeholderText = placeholder
        self.maxLength = maxLength
        self.endClourse = clourse
    }
    
    
    //MARK: - private method
    fileprivate func setupCell(){
        
        self.contentView.addSubview(inputTextView)
        inputTextView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
 
    //MARK: - var & let 
    
    fileprivate var maxLength = 0
    
    fileprivate lazy var inputTextView:YYTextView = {
        
        let textView = YYTextView()
        textView.placeholderFont = UIFont.mo_font()
        textView.placeholderTextColor = UIColor.mo_silver()
        textView.font = UIFont.mo_font()
        textView.textColor = UIColor.mo_lightBlack()
        textView.delegate = self
        return textView
    }()
    
    fileprivate var endClourse:((String)->Void)?

}

extension PublishTaskCell: YYTextViewDelegate{
    
    func textViewDidEndEditing(_ textView: YYTextView) {
        
        endClourse?(textView.text)
    }
    
    func textViewShouldEndEditing(_ textView: YYTextView) -> Bool {
        
        return true
    }
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let string = (textView.text)! as NSString
        let toBeString = string.replacingCharacters(in: range, with: text)
        if toBeString.characters.count > maxLength && maxLength > 0{
            textView.text = (toBeString as NSString).substring(to: maxLength)
            return false
        }
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
