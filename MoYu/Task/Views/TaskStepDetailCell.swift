//
//  TaskStepDetailCell.swift
//  MoYu
//
//  Created by Chris on 2016/9/24.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import YYText
import SnapKit

class TaskStepDetailCell: UITableViewCell {


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var identifier:String{
        return "taskStepDetailIdentifier"
    }
    
    class func cell(tableView aTableView:UITableView) ->TaskStepDetailCell{
        
        guard let cell = aTableView.dequeueReusableCellWithIdentifier( identifier) as? TaskStepDetailCell else{
            return TaskStepDetailCell(style: .Default, reuseIdentifier: identifier)
        }
        return cell
    }
    
    func update(model item:TaskModel, isStep:Bool){
        
        if isStep{
            stepTextView.text = item.step
        }else{
            stepTextView.text = item.content
        }
    }
    
    
    //MARK: - private methods
    private func setupCell(){
        
        contentView.addSubview(stepTextView)
        stepTextView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(EdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
    
    private lazy var stepTextView:YYTextView = {
        let text = YYTextView()
        text.textColor = UIColor.mo_lightBlack()
        text.font = UIFont.mo_font()
        text.editable = false
        return text;
    }()
}
