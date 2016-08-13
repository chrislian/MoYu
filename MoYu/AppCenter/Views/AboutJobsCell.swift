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
    class func cell(tableView tableView:UITableView)->AboutJobsCell{
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.AppCenter.Cell.aboutJobs) as? AboutJobsCell else{
            return AboutJobsCell(style: .Default, reuseIdentifier: SB.AppCenter.Cell.aboutJobs)
        }
        return cell
    }
    
    func update(item item:AboutJobItem){
        
        dateLabel.text = item.create_time.mo_ToString(.Detail)
        usernameLabel.text = item.nickname
        commentLabel.text = item.memo
        //headImageView.mo_loadRoundImage(item.avator, placeholder: UIImage(named: "defalutHead")!)
        
        jobZoneItem = item
    }
    
    
    //MARK: - private method
    
    dynamic private func zanTap(sender:UITapGestureRecognizer){
        
        self.zanClourse?(jobZoneItem)
    }
    dynamic private func commentTap(sender:UITapGestureRecognizer){
        
        self.commentClourse?(jobZoneItem)
    }
    
    private func setupCell(){
        
        zanImageView.userInteractionEnabled = true
        commentImageView.userInteractionEnabled = true
        
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
    
    private var jobZoneItem:AboutJobItem?
    var zanClourse:(AboutJobItem?->Void)?
    var commentClourse:(AboutJobItem?->Void)?
}
