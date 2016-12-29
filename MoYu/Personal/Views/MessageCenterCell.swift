//
//  MessageCenterCell.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MessageCenterCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = CGRect(x: 12, y: self.frame.origin.y, width: MoScreenWidth - 24, height: self.frame.size.height)
        
        self.layer.borderColor = UIColor.mo_mercury.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2.0
    }
    

    //MARK: - public method
    class func cell(tableView:UITableView)->MessageCenterCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Personal.Cell.messageCenterCell) as? MessageCenterCell else{
            return MessageCenterCell(style: .default, reuseIdentifier: SB.Personal.Cell.messageCenterCell)
        }
        return cell
    }
    
    func update(item:MessageCenterItem){
        
        contentLabel.text = item.description
        
        titleLabel.text = item.title
        
        if let date = item.createTime {
            let string = "\(date.mo_month())月\(date.mo_day())日"
            dateLabel.text = string
        }
        
        thumbnialImageHeight.constant = 0
        
    }
    
    
    //MARK: - private method
    fileprivate func setupCell(){
        titleLabel.textColor = UIColor.mo_lightBlack
        titleLabel.font = UIFont.mo_font(.bigger)

        dateLabel.textColor = UIColor.mo_lightBlack
        dateLabel.font = UIFont.mo_font(.smaller)
        
        contentLabel.textColor = UIColor.mo_lightBlack
        contentLabel.font = UIFont.mo_font()
        
        thumbnialImageView.contentMode = .scaleAspectFill
    }
    
    
    //MARK: - private var & let
    @IBOutlet weak var thumbnialImageHeight: NSLayoutConstraint!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnialImageView: UIImageView!
}
