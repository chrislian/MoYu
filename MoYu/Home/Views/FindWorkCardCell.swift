//
//  FindWorkCardCell.swift
//  MoYu
//
//  Created by lxb on 2016/11/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class FindWorkCardCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCell()
    }
    
    static var identifier:String{
        return "FindWorkCardCellIdentifier"
    }
    
    //MARK: - public methods
    func update(model:HomeMenuModel){
        
        titleLabel.text = model.content
        subTitleLabel.text = model.address
        
        usernameLabel.text = model.name
        
        payLabel.text = "\(model.commission)元/次"
    }
    
    //MARK: - private methods
    
    private func setupCell(){
        self.backgroundColor = UIColor.clear

        payLabel.textColor = UIColor.mo_main()
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var avatorImageView: MOImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var authImageView: UIImageView!
}
