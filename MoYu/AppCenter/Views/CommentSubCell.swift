//
//  CommentSubCell.swift
//  MoYu
//
//  Created by lxb on 2016/12/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class CommentSubCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //MARK: - private methods
    private func benchText(idx:Int)->String{
        switch idx {
        case 2:
            return "沙发"
        case 3:
            return "板凳"
        case(let value):
            return "\(value)楼"
        }
    }
    
    //MARK: - public mehotds
    class func cell(tableView:UITableView)->CommentSubCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.AppCenter.Cell.commentsSub) as? CommentSubCell else{
            return CommentSubCell(style: .default, reuseIdentifier: SB.AppCenter.Cell.commentsSub)
        }
        return cell
    }
    
    func update(model:AboutJobSubItem,index:Int){
        
        avatorImageView.mo_loadRoundImage("")
        benchLabel.text = benchText(idx: index)
        usernameLabel.text = model.nickname
        createTimeLabel.text = model.create_date.mo_ToString(.detail)
        commentsLabel.text = model.comment
        
    }
    
    //MARK: - var & let
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var benchLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var avatorImageView: MOImageView!
}
