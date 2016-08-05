//
//  UserHeaderCell.swift
//  MoYu
//
//  Created by Chris on 16/7/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.setupCell()
    }
    
    //MARK: - public method
    func update(usename name:String, source:String = "",image:String = ""){
        headerImageView.mo_loadImage(image, placeholder: UIImage(named: "defalutHead")!)
        usernameLabel.text = name
        signInFromLabel.text = source
    }
    
    //MARK: - private method
    private func setupCell(){
    
        headerImageView.contentMode = .ScaleAspectFill
        headerImageView.layer.cornerRadius = headerImageView.frame.size.width/2
        headerImageView.layer.masksToBounds = true
        
        usernameLabel.textColor = UIColor.mo_lightBlack()
        usernameLabel.font = UIFont.mo_font(.bigger)
        usernameLabel.text = "无名"
        
        signInFromLabel.textColor = UIColor.mo_main()
        signInFromLabel.font = UIFont.mo_font()
        signInFromLabel.text = ""
    }
    

    //MARK: - var & let
    @IBOutlet weak var signInFromLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
}
