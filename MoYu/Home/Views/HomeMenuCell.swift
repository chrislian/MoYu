//
//  HomeMenuCell.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeMenuCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    //MARK: - public method
    
    class func cell(tableView tableView:UITableView) -> HomeMenuCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Main.Cell.homeMenu) as? HomeMenuCell else{
            return HomeMenuCell(style: .Default, reuseIdentifier: SB.Main.Cell.homeMenu)
        }
        return cell
    }
    
    func update(item item:HomeMenuModel){
        
        cellImageView.image = UIImage(named: "home_menu_sender")
        cellTitleLabel.text = item.content
        publishDateLabel.text = item.createtime.mo_ToString(.Detail)
        areaLabel.text = item.address
        priceLabel.text = "\(item.commission)¥/天"
    }
    
    
    //MARK: - prvate method
    private func setupCell(){
        
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var cellImageView: MOImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}
