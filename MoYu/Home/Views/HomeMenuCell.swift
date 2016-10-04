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
    
    class func cell(tableView:UITableView) -> HomeMenuCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Main.Cell.homeMenu) as? HomeMenuCell else{
            return HomeMenuCell(style: .default, reuseIdentifier: SB.Main.Cell.homeMenu)
        }
        return cell
    }
    
    func update(item:HomeMenuModel){
        
        cellImageView.image = UIImage(named: "home_menu_sender")
        cellTitleLabel.text = item.content
        publishDateLabel.text = item.createtime.mo_ToString(.detail)
        areaLabel.text = item.address
        priceLabel.text = "\(item.commission)¥/天"
    }
    
    
    //MARK: - prvate method
    fileprivate func setupCell(){
        
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var cellImageView: MOImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}
