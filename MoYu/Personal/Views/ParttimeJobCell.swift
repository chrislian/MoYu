//
//  ParttimeJobCell.swift
//  MoYu
//
//  Created by Chris on 16/8/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class ParttimeJobCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupCell()
    }
    
    //MARK: - public method
    class func cell(tableView tableView:UITableView) -> ParttimeJobCell{
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Personal.Cell.parttimeJobCell) as? ParttimeJobCell else{
            return ParttimeJobCell(style: .Default, reuseIdentifier: SB.Personal.Cell.parttimeJobCell)
        }
        return cell
    }
    
    func update(item type:Int){
        
        
        if type == 1{
            progressViewHeightConstraint.constant = 4.0
            progressView.backgroundColor = UIColor.whiteColor()
        }else{
            progressViewHeightConstraint.constant = 16.0
            progressView.backgroundColor = UIColor.mo_lightBlack()
        }
    }
    
    
    //MARK: - private method
    private func setupCell(){
        
        progressView.backgroundColor = UIColor.whiteColor()
        
        amountLabel.textColor = UIColor.mo_main()
        amountLabel.font = UIFont.mo_font()
        amountLabel.textAlignment = .Right
        
        statusLabel.textColor = UIColor.mo_silver()
        statusLabel.font = UIFont.mo_font()
        
        briefLabel.textColor = UIColor.grayColor()
        briefLabel.font = UIFont.mo_font(.smaller)
        
        titleLabel.textColor = UIColor.mo_lightBlack()
        titleLabel.font = UIFont.mo_font(.big)
        
    }
    
    //MARK: - var & let
    
    @IBOutlet weak var progressViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var briefLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatorImageView: UIImageView!
}
