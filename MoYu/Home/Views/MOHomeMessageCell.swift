//
//  MOHomeMessageCell.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOHomeMessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        
    }

    //MARK: - private method
    private func setupView(){
        //TODO:
    }
    
    //MARK: - var & let
    @IBOutlet weak var headImageView: MOImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}
