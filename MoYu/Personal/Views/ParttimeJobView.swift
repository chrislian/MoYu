//
//  ParttimeJobView.swift
//  MoYu
//
//  Created by Chris on 16/8/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


class ParttimeJobView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupView()
    }

    //MARK: - event response
    dynamic fileprivate func buttonTap(_ button:UIButton){
        
        guard let type = ParttimeJobType(rawValue: button.tag) , buttonType != type else{
            return
        }
        
        buttonType = type
        
        self.updateButton(type: type)
        
        self.changeButtonType?(type)
    }
    
    
    func updateButton(type:ParttimeJobType){
        
        switch type{
        case .recurit:
            myRecuritButton.setTitleColor(UIColor.mo_main, for: UIControlState())
            myRecuritLine.backgroundColor = UIColor.mo_main
            myPublicButton.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
            myPublicLine.backgroundColor = UIColor.white
        case .announce:
            myPublicButton.setTitleColor(UIColor.mo_main, for: UIControlState())
            myPublicLine.backgroundColor = UIColor.mo_main
            myRecuritButton.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
            myRecuritLine.backgroundColor = UIColor.white
        }
    }
    
    //MARK: - private method
    
    fileprivate func setupView(){
        
        self.updateButton(type: buttonType)
        
        myRecuritButton.titleLabel?.font = UIFont.mo_font()
        myPublicButton.titleLabel?.font = UIFont.mo_font()
        
        myRecuritButton.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        myPublicButton.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        
        myRecuritButton.tag = ParttimeJobType.recurit.rawValue
        myPublicButton.tag = ParttimeJobType.announce.rawValue
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var myPublicLine: UIView!
    @IBOutlet weak var myRecuritLine: UIView!
    @IBOutlet weak var myPublicButton: UIButton!
    @IBOutlet weak var myRecuritButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var buttonType = ParttimeJobType.recurit
    
    var changeButtonType:((_ type:ParttimeJobType)->Void)?
}
