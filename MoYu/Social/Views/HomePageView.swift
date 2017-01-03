//
//  HomePageView.swift
//  MoYu
//
//  Created by lxb on 2017/1/3.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit

class HomePageView: UIView {

  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerView.backgroundColor = UIColor.mo_lightYellow
        
        setupView()
    }
    
    //MARK: - private methods
    private func setupView(){
        
        avatorImageView.contentMode = .scaleAspectFill
        avatorImageView.clipsToBounds = true
        
        usernameLabel.textColor = UIColor.mo_lightBlack
//        usernameLabel.text = ""
        
        motionLabel.textColor = UIColor.lightGray
//        motionLabel.text = ""
        
        distanceLabel.textColor = UIColor.mo_main
//        distanceLabel.text = ""
        
        pkLabel.backgroundColor = UIColor.mo_main
        pkLabel.layer.cornerRadius = pkLabel.frame.size.height/2
        pkLabel.layer.masksToBounds = true
        
        signLabel.textColor = UIColor.lightGray
        sayHelloLabel.textColor = UIColor.lightGray
        
    }
    
    //MARK: - event response
    @IBAction func signButton(_ sender: UIButton) {
    }
    
    @IBAction func sayHelloButton(_ sender: UIButton) {
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var avatorImageView: MOImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var motionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pkLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var sayHelloLabel: UILabel!
}
