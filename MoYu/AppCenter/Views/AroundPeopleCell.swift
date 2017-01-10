//
//  AroundPeopleCell.swift
//  MoYu
//
//  Created by lxb on 2016/12/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AroundPeopleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    //MARK: - public methods
    class func cell(tableView:UITableView)->AroundPeopleCell{
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.AppCenter.Cell.aroundPeople) as? AroundPeopleCell else{
            return AroundPeopleCell(style: .default, reuseIdentifier: SB.AppCenter.Cell.aroundPeople)
        }
        return cell
    }
    
    func update(model:AroundPeopleModel){
        
        avatorImageView.mo_loadRoundImage(model.avator,radius: avatorImageView.frame.size.height/2)
        motionLabel.text = model.autograph
        usernameLabel.text = model.nickname
        
        switch model.sex {
        case .none:
            sexImageView.image = UIImage()
        case .male:
            sexImageView.image = UIImage(named: "icon_male")
        case .female:
            sexImageView.image = UIImage(named: "icon_female")
        }
        
        let currentLocation = UserManager.sharedInstance.currentLocation
        distanceLabel.text = currentLocation.distance(latitude: model.latitude, longitude: model.longitude)
    }
    

    //MARK: - private methods
    private func setupCell(){
        
        sexImageView.contentMode = .scaleAspectFit
        
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var sexImageView: UIImageView!
    @IBOutlet weak var motionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatorImageView: MOImageView!
}
