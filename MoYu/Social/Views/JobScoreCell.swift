//
//  JobScoreCell.swift
//  MoYu
//
//  Created by lxb on 2017/1/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit

class JobScoreCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        subView.backgroundColor = UIColor.mo_background
    }

    class func cell(tableView:UITableView)->JobScoreCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Social.Cell.jobScore) as? JobScoreCell else{
            return JobScoreCell(style: .default, reuseIdentifier: SB.Social.Cell.jobScore)
        }
        return cell
    }

    func update(){
        
        //TODO: - update
    }
    
    
    @IBOutlet weak var jobScoreLabel: UILabel!
    @IBOutlet weak var subView: UIView!
}
