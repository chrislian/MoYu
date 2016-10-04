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
    class func cell(tableView:UITableView) -> ParttimeJobCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Personal.Cell.parttimeJobCell) as? ParttimeJobCell else{
            return ParttimeJobCell(style: .default, reuseIdentifier: SB.Personal.Cell.parttimeJobCell)
        }
        return cell
    }
  
    func update(cellType type:JobManagerCellType){
        
        switch type {
        case .getParttime(let model):
            updateGet(status: model.status,
                   title: model.name,
                   content: model.content,
                   time: model.createtime,
                   amount: model.commission)
            
        case .getTask(let model):
            updateGet(status: model.status,
                   title: model.name,
                   content: model.content,
                   time: model.disposetime,
                   amount: model.commission)
        case .postTask(let model):
            
            updatePost(status: model.status,
                       title: model.name,
                       content: model.content,
                       time: model.createtime,
                       amount: model.commission,
                       progress: model.order/model.sum)
            
        case .postParttime(let model):
            updatePost(status: model.status,
                       title: model.name,
                       content: model.content,
                       time: model.createtime,
                       amount: model.commission,
                       progress: model.order/model.sum)
        }
        
    }
    
    
    //MARK: - private method
    
    fileprivate func updateGet(status:Int, title:String, content:String, time:Double, amount:Double){
        
        if status == 1{
            statusLabel.text = "进行中"
        }else if status == 2{
            statusLabel.text = "等待商家确认"
        }else{
            statusLabel.text = ""
        }
        
        titleLabel.text = title
        briefLabel.text = content
    
    
        let date = Date(timeIntervalSince1970: time)
        dateLabel.text = Date.mo_stringFromDatetime2(date)
        
        amountLabel.text = String(format: "%0.2f元", amount)
        
        progressViewHeightConstraint.constant = 0
        progressView.isHidden = true
        
        avatorImageView.mo_loadImage("")
    }
    
    fileprivate func updatePost(status:Int, title:String, content:String,time:Double, amount:Double, progress:Double){
        if status == 1{
            statusLabel.text = "进行中"
        }else if status == 2{
            statusLabel.text = "已完成"
        }else{
            statusLabel.text = ""
        }
        titleLabel.text = title
        briefLabel.text = content
        
        let date = Date(timeIntervalSince1970: time)
        dateLabel.text = Date.mo_stringFromDatetime2(date)
        
        amountLabel.text = String(format: "%0.2f元", amount)
        
        progressViewHeightConstraint.constant = 16
        workProgress.isHidden = false
        
        workProgress.setProgress(Float(progress), animated: true)
        
        avatorImageView.mo_loadImage("")
    }
    
    
    fileprivate func setupCell(){
        
        progressView.backgroundColor = UIColor.white
        
        amountLabel.textColor = UIColor.mo_main()
        amountLabel.font = UIFont.mo_font()
        amountLabel.textAlignment = .right
        
        statusLabel.textColor = UIColor.mo_silver()
        statusLabel.font = UIFont.mo_font()
        
        briefLabel.textColor = UIColor.gray
        briefLabel.font = UIFont.mo_font(.smaller)
        
        titleLabel.textColor = UIColor.mo_lightBlack()
        titleLabel.font = UIFont.mo_font(.big)
        
        
        progressView.addSubview(workProgress)
        workProgress.snp.makeConstraints { (make) in
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
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progressTintColor = UIColor.mo_main()
        progress.trackTintColor = UIColor.mo_silver()
        progress.layer.cornerRadius = 2.5
        progress.layer.masksToBounds = true
        return progress
    }()
}
