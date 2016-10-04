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
    
    class func cell(tableView:UITableView) -> BalanceCell{
        let cellID = "balanceCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? BalanceCell
        if cell == nil{
            cell = BalanceCell(style: .default, reuseIdentifier: cellID)
        }
        return cell!
    }
    
    func update( _ item: ConsumeHistoryItem ){
    
        weakLabel.text = "星期\(item.date.mo_weekday())"
        dateLabel.text = String(format: "%02d-%d", item.date.mo_month(),item.date.mo_day())
        
        consumeLabel.text = "-\(item.consume)元"
        sourceDetailLabel.text = item.detail

        sourceImageView.image = UIImage(named: "defalutHead")
    }

    fileprivate func layout(){
        
        self.contentView.addSubview(weakLabel)
        weakLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(self.contentView).offset(8)
            make.width.equalTo(40)
        }
        
        self.contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(weakLabel.snp.bottom).offset(8)
            make.width.equalTo(weakLabel)
        }
        
        
        self.contentView.addSubview(sourceImageView)
        sourceImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(weakLabel.snp.right).offset(15)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        
        self.contentView.addSubview(consumeLabel)
        consumeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sourceImageView.snp.right).offset(15)
            make.centerY.equalTo(weakLabel)
            make.right.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(sourceDetailLabel)
        sourceDetailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sourceImageView.snp.right).offset(15)
            make.centerY.equalTo(dateLabel)
            make.right.equalTo(self.contentView)
        }
    }
    
    //MARK: - var & let
    fileprivate let weakLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = "周二"
        return label
    }()
    
    fileprivate let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = "07-26"
        return label
    }()
    
    
    fileprivate let sourceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    fileprivate let consumeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font(.smaller)
        label.text = "-0.00元"
        return label
    }()
    
    fileprivate let sourceDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_silver()
        label.font = UIFont.mo_font(.smaller)
        label.text = "消费详情"
        return label
    }()
    
}
