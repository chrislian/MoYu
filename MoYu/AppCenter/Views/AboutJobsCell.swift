//
//  AboutJobsCell.swift
//  MoYu
//
//  Created by Chris on 16/4/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AboutJobsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupCell()
    
    }
    
    //MARK: - public method
    class func cell(tableView:UITableView)->AboutJobsCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.AppCenter.Cell.aboutJobs) as? AboutJobsCell else{
            return AboutJobsCell(style: .default, reuseIdentifier: SB.AppCenter.Cell.aboutJobs)
        }
        return cell
    }
    
    func update(item:AboutJobItem){
        
        dateLabel.text = item.create_time.mo_ToString(.detail)
        usernameLabel.text = item.nickname
        commentLabel.text = item.memo
        //headImageView.mo_loadRoundImage(item.avator, placeholder: UIImage(named: "defalutHead")!)
        
        jobZoneItem = item
    }
    
    
    //MARK: - private method
    
    dynamic fileprivate func zanTap(_ sender:UITapGestureRecognizer){
        
        self.zanClourse?(jobZoneItem)
    }
    dynamic fileprivate func commentTap(_ sender:UITapGestureRecognizer){
        
        self.commentClourse?(jobZoneItem)
    }
    
    fileprivate func setupCell(){
        
        zanImageView.isUserInteractionEnabled = true
        commentImageView.isUserInteractionEnabled = true
        
        let zan = UITapGestureRecognizer(target: self, action: #selector(zanTap(_:)))
        zanImageView.addGestureRecognizer(zan)
        
        let comment = UITapGestureRecognizer(target: self, action: #selector(commentTap(_:)))
        commentImageView.addGestureRecognizer(comment)
    }


    //MARK: - var & let
    @IBOutlet weak var headImageView: MOImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var zanImageView: UIImageView!
    
    fileprivate var jobZoneItem:AboutJobItem?
    var zanClourse:((AboutJobItem?)->Void)?
    var commentClourse:((AboutJobItem?)->Void)?
}
