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
    
    class func cell(tableView tableView:UITableView)->TaskDetailCell{

        guard let cell = tableView.dequeueReusableCellWithIdentifier( identifier ) as? TaskDetailCell else{
            return TaskDetailCell(style: .Default, reuseIdentifier: identifier)
        }
        return cell
    }
    
    func update(item model:TaskModel){
        //TODO: -
        
        //avatorImageView.mo_loadRoundImage("", radius: avatorImageView.bounds.size.width/2, placeholder: UIImage(named: "defaultAvator"))
        
    }
    
    //MARK: - private method
    private func setupCell(){
        amountLabel.textColor = UIColor.mo_main()
        amountLabel.font = UIFont.mo_font(.biggest)
        
        rightButton.backgroundColor = UIColor.mo_main()
        rightButton.setTitle("注册", forState: .Normal)
        rightButton.layer.cornerRadius = rightButton.bounds.size.height/2
        rightButton.layer.masksToBounds = true
        
        stepLabel.textColor = UIColor.mo_lightBlack()
        stepLabel.font = UIFont.mo_font(.smaller)
        
        contentLabel.textColor = UIColor.mo_lightBlack()
        contentLabel.font = UIFont.mo_font(.small)
        
        titleLabel.textColor = UIColor.mo_lightBlack()
        titleLabel.font = UIFont.mo_font(.bigger)
        
        avatorImageView.contentMode = .ScaleAspectFill
        avatorImageView.clipsToBounds = true
        
    }
    
    
    //MARK: - var & let
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatorImageView: MOImageView!
}
