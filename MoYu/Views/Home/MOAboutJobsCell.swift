//
//  MOAboutJobsTableViewCell.swift
//  MoYu
//
//  Created by Chris on 16/4/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOAboutJobsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBOutlet weak var headImageView: MOImageView!
    @IBOutlet weak var usernameLabel: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
}
