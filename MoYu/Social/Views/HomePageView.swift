//
//  HomePageView.swift
//  MoYu
//
//  Created by lxb on 2017/1/3.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit

enum HomePageHeaderType {
    
    case sign//备注
    case pk//pk
    case sayHi//打招呼
}

class HomePageView: UIView {

  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerView.backgroundColor = UIColor.mo_lightYellow
        
        setupView()
    }
    
    //MARK: - public methods
    func update(model:AroundPeopleModel){
        
        avatorImageView.mo_loadRoundImage(model.avator,radius: avatorImageView.frame.size.height/2)
        usernameLabel.text = model.nickname
        motionLabel.text = model.autograph
        let currentLocation = UserManager.sharedInstance.currentLocation
        distanceLabel.text = "距离 " + model.location.distance(location: currentLocation)
    }
    
    //MARK: - private methods
    private func setupView(){
        
        avatorImageView.contentMode = .scaleAspectFill
        avatorImageView.clipsToBounds = true
        
        usernameLabel.textColor = UIColor.mo_main
        usernameLabel.text = ""
        
        motionLabel.textColor = UIColor.lightGray
        motionLabel.text = ""
        
        distanceLabel.textColor = UIColor.mo_main
        distanceLabel.text = ""
        
        pkLabel.backgroundColor = UIColor.mo_main
        pkLabel.layer.cornerRadius = pkLabel.frame.size.height/2
        pkLabel.layer.masksToBounds = true
        
        signLabel.textColor = UIColor.lightGray
        sayHelloLabel.textColor = UIColor.lightGray
        
        pkLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(pkTap(_:)))
        pkLabel.addGestureRecognizer(tap)
        
    }
    
    //MARK: - event response
    @IBAction func signButton(_ sender: UIButton) {
        tapClourse?(.sign)
    }
    
    @IBAction func sayHelloButton(_ sender: UIButton) {
        tapClourse?(.sayHi)
    }
    
    @objc private func pkTap(_ sender:UITapGestureRecognizer){
        tapClourse?(.pk)
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
    
    var tapClourse:((HomePageHeaderType)->Void)?
}
