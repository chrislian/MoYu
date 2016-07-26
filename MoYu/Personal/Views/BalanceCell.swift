//
//  BalanceCell.swift
//  MoYu
//
//  Created by Chris on 16/7/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class BalanceCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cell(tableView tableView:UITableView) -> BalanceCell{
        let cellID = "balanceCellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? BalanceCell
        if cell == nil{
            cell = BalanceCell(style: .Default, reuseIdentifier: cellID)
        }
        return cell!
    }
    
    func update( item: ConsumeHistoryItem ){
    
        weakLabel.text = "星期\(item.date.mo_weekday())"
        dateLabel.text = String(format: "%02d-%d", item.date.mo_month(),item.date.mo_day())
        
        consumeLabel.text = "-\(item.consume)元"
        sourceDetailLabel.text = item.detail

        sourceImageView.image = UIImage(named: "defalutHead")
    }

    private func layout(){
        
        self.contentView.addSubview(weakLabel)
        weakLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(self.contentView).offset(8)
            make.width.equalTo(40)
        }
        
        self.contentView.addSubview(dateLabel)
        dateLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(weakLabel.snp_bottom).offset(8)
            make.width.equalTo(weakLabel)
        }
        
        
        self.contentView.addSubview(sourceImageView)
        sourceImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(weakLabel.snp_right).offset(15)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        
        self.contentView.addSubview(consumeLabel)
        consumeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(sourceImageView.snp_right).offset(15)
            make.centerY.equalTo(weakLabel)
            make.right.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(sourceDetailLabel)
        sourceDetailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(sourceImageView.snp_right).offset(15)
            make.centerY.equalTo(dateLabel)
            make.right.equalTo(self.contentView)
        }
    }
    
    //MARK: - var & let
    private let weakLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = "周二"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = "07-26"
        return label
    }()
    
    
    private let sourceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()

    private let consumeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = "-0.00元"
        return label
    }()
    
    private let sourceDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_silver()
        label.font = UIFont.mo_font(.smaller)
        label.text = "消费详情"
        return label
    }()
    
}
