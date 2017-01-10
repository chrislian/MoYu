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
        headImageView.mo_loadRoundImage(item.avator,radius: headImageView.frame.size.height/2)
        zanCountLabel.text = item.zan
        
        commentCountLabel.text = "\(item.replylists.count)"
        
        jobZoneItem = item
    }
    
    
    @IBAction func zanButtonTap(_ sender: UIButton) {
        zanClourse?(jobZoneItem)
    }
    @IBAction func commentButtonTap(_ sender: UIButton) {
        commentClourse?(jobZoneItem)
    }
    //MARK: - private method
    
    fileprivate func setupCell(){
        
    }


    //MARK: - var & let
    @IBOutlet weak var headImageView: MOImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var zanCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    fileprivate var jobZoneItem:AboutJobItem?
    var zanClourse:((AboutJobItem?)->Void)?
    var commentClourse:((AboutJobItem?)->Void)?
}
