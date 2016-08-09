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
            workProgress.hidden = true
        }else{
            progressViewHeightConstraint.constant = 16.0
            workProgress.hidden = false
            workProgress.setProgress(0.68, animated: true)
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
        
        
        progressView.addSubview(workProgress)
        workProgress.snp_makeConstraints { (make) in
            make.center.equalTo(progressView)
            make.size.equalTo(CGSize(width: 150, height: 5))
        }
        
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
    
    lazy var workProgress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .Bar)
        progress.progressTintColor = UIColor.mo_main()
        progress.trackTintColor = UIColor.mo_silver()
        progress.layer.cornerRadius = 2.5
        progress.layer.masksToBounds = true
        return progress
    }()
}
