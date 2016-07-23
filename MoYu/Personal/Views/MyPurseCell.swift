//
//  MyPurseCell.swift
//  MoYu
//
//  Created by Chris on 16/7/23.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MyPurseCell: UITableViewCell {

    class func cell(tableView:UITableView)->MyPurseCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(SB.Personal.Cell.myPurseCell)  as? MyPurseCell
        if cell == nil{
            cell = MyPurseCell(style: .Default, reuseIdentifier: SB.Personal.Cell.myPurseCell)
        }
        cell?.setupCell()
        return cell!
    }
    
    func update(icon image:UIImage?, leftText:String, rightText:String = ""){
        
        leftLabel.text = leftText
        rightLabel.text = rightText
        
        iconImageView.image = image
    }
    
    
    //MARK: - pirvate method
    private func setupCell(){
        iconImageView.contentMode = .ScaleAspectFit
        leftLabel.textColor = UIColor.mo_lightBlack()
        leftLabel.font = UIFont.mo_font()
        
        rightLabel.textColor = UIColor.mo_silver()
        rightLabel.font = UIFont.mo_font()
        rightLabel.text = ""
    }
    
    
    
    
    //MARK: - var & let

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
}
