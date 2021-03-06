//
//  LeftMenuCell.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - public method
    func updateCell(_ image:UIImage , text:String){
        cellImageView.image = image
        cellTextLabel.text = text
    }

    //MARK: - var & let
    @IBOutlet weak var cellTextLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
}
