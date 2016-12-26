//
//  CommentTopCell.swift
//  MoYu
//
//  Created by lxb on 2016/12/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class CommentTopCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        setupCell()
    }

    
    //MARK: - private mehtods
    private func setupCell(){
    
    }
    
    //MARK: - public methods
    class func cell(tableView:UITableView)->CommentTopCell{
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.AppCenter.Cell.commentsTop) as? CommentTopCell else{
            return CommentTopCell(style: .default, reuseIdentifier: SB.AppCenter.Cell.commentsTop)
        }
        return cell
    }
    
    func update(comments:String, count:Int){
        
        commentsDetailLabel.text = comments
        
        commentsCountLabel.text = "\(count)"
        
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var commentsDetailLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
}
