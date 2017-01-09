//
//  PeopleAuthCell.swift
//  MoYu
//
//  Created by lxb on 2017/1/9.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit

enum PeopleAuthType:Int {
    case personal = 100
    case merchant
}


class PeopleAuthCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    //MARK: - private methods
    private func setupCell(){
        
        personAuthImageView.contentMode = .scaleAspectFit
        merchantAuthImageView.contentMode = .scaleAspectFit
        
        personAuthLabel.font = UIFont.mo_font()
        merchantAuthLabel.font = UIFont.mo_font()
    }
    
    
    //MARK : - public methods
    class func cell(tableView:UITableView)->PeopleAuthCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Social.Cell.peopleAuth) as? PeopleAuthCell else{
            return PeopleAuthCell(style: .default, reuseIdentifier: SB.Social.Cell.peopleAuth)
        }
        return cell
    }
    
    func update(personAuth:Bool,merchantAuth:Bool){
        
        if personAuth {
            personAuthImageView.image = UIImage(named: "icon_personal_auth")
            personAuthLabel.textColor = UIColor.mo_main
        }else{
            personAuthImageView.image = UIImage(named: "icon_personal_auth_yet")
            personAuthLabel.textColor = UIColor.lightGray
        }
        
        if merchantAuth {
            merchantAuthImageView.image = UIImage(named: "icon_merchant_auth")
            merchantAuthLabel.textColor = UIColor.mo_main
        }else{
            merchantAuthImageView.image = UIImage(named: "icon_merchant_auth_yet")
            merchantAuthLabel.textColor = UIColor.lightGray
        }
    }
    
    //MARK: - event response
    @IBAction func authClick(_ sender: UIButton) {
        
        guard let type = PeopleAuthType(rawValue: sender.tag) else{
            return
        }
        authButtonClourse?(type)
    }
    
    
    //MARK: - var & let
    
    var authButtonClourse:((PeopleAuthType)->Void)?
    
    @IBOutlet weak var personAuthImageView: UIImageView!
    @IBOutlet weak var personAuthLabel: UILabel!
    @IBOutlet weak var merchantAuthLabel: UILabel!
    @IBOutlet weak var merchantAuthImageView: UIImageView!
}
