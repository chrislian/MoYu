//
//  TaskDetailCell.swift
//  MoYu
//
//  Created by Chris on 16/9/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class TaskDetailCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    class var identifier: String {
        return "taskDetailCell"
    }
    
    class func cell(tableView:UITableView)->TaskDetailCell{

        guard let cell = tableView.dequeueReusableCell( withIdentifier: identifier ) as? TaskDetailCell else{
            return TaskDetailCell(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }
    
    func update(item model:TaskModel, onlyContent:Bool = false){
        
        avatorImageView.mo_loadRoundImage("", radius: avatorImageView.bounds.size.width/2)
        
        if onlyContent{
            titleLabel.text = ""
            
            contentLabel.text = model.name
            
            stepLabel.text = ""
        }else{
            
            titleLabel.text = model.name
            
            contentLabel.text = model.content
            
            stepLabel.text = model.step
        }
        amountLabel.attributedText = commission(model.commission)
    }
    
    func update(item model:HomeMenuModel){
        
        avatorImageView.mo_loadRoundImage("", radius: avatorImageView.bounds.size.width/2)
        titleLabel.text = ""
        contentLabel.text = model.name
        stepLabel.text = ""
        amountLabel.attributedText = commission(Double(model.commission) ?? 0)

    }
    
    
    //MARK: - private method
    
    fileprivate func commission( _ value:Double)->NSAttributedString{
        
        let color = UIColor ( red: 1.0, green: 0.502, blue: 0.0, alpha: 1.0 )
        let attrString = NSMutableAttributedString()
        let str1 = NSAttributedString(string: "+ ", attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: UIFont.mo_font(.smaller)])
        let str2 = NSAttributedString(string: String(format: "%0.2f",value), attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: UIFont.mo_font(.biggest)])
        let str3 = NSAttributedString(string: "元", attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: UIFont.mo_font(.smallest)])
        attrString.append(str1)
        attrString.append(str2)
        attrString.append(str3)
        return attrString
    }
    
    fileprivate func setupCell(){
        amountLabel.textColor = UIColor.mo_main()
        amountLabel.font = UIFont.mo_font(.biggest)
        
        stepLabel.textColor = UIColor.mo_lightBlack()
        stepLabel.font = UIFont.mo_font(.smaller)
        
        contentLabel.textColor = UIColor.mo_lightBlack()
        contentLabel.font = UIFont.mo_font(.small)
        
        titleLabel.textColor = UIColor.mo_lightBlack()
        titleLabel.font = UIFont.mo_font(.bigger)
        
        avatorImageView.contentMode = .scaleAspectFill
        avatorImageView.clipsToBounds = true
        
    }
    
    //MARK: - var & let
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatorImageView: MOImageView!
}
