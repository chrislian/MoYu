//
//  MOHomeMenuCell.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOHomeMenuCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    //MARK: - public method
    func updateCellWithImage(item:MOHomeMenuItem){
        
        cellImageView.image = UIImage(named: item.imageName)
        cellTitleLabel.text = item.title
        publishDateLabel.text = item.date
        areaLabel.text = item.area
        priceLabel.text = item.price
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
