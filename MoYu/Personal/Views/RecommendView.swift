//
//  RecommendView.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class RecommendView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupView()
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        self.backgroundColor = UIColor.mo_background()
        
        promptBackView.layer.cornerRadius = 2
        promptBackView.layer.masksToBounds = true
        promptBackView.layer.borderWidth = 0.5
        promptBackView.layer.borderColor = UIColor.mo_mercury().cgColor
        
        inviteFriendButton.layer.cornerRadius = 3
        inviteFriendButton.layer.masksToBounds = true
        
        promptImageView.clipsToBounds = true
        promptImageView.image = UIImage(named: "recommendDefault")
    }
    
    //MARK: - var & let
    @IBOutlet weak var promptBackView: UIView!
    @IBOutlet weak var promptImageView: UIImageView!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var inviteFriendButton: UIButton!
}
