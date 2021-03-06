//
//  UIViewController+MoYu.swift
//  MoYu
//
//  Created by Chris on 16/9/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

extension UIViewController{
    
    /**
     通过`titleView`设置导航栏的title
     
     - parameter aTitle:
     */
    func mo_navigationBar(title aTitle:String,alpha:CGFloat = 1.0){
        
        self.navigationItem.titleView = nil
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 43))
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.mo_lightBlack.withAlphaComponent(alpha)
        label.font = UIFont.mo_font(.bigger)
        label.textAlignment = .center
        label.text = aTitle
        
        self.navigationItem.titleView  = label
    }
    
    //MARK: - event response
    @objc fileprivate func mo_dismissViewController(tap sender:AnyObject){
        
        dismiss(animated: true, completion: nil)
    }
    
    /**
     设置root navigation item 左
     
     - parameter name: UIImage
     */
    func mo_rootLeftBackButton(image name:UIImage? = UIImage(named: "nav_back") ){
        
        self.navigationItem.leftBarButtonItems = {
            
            let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil , action: nil)
            spaceItem.width = -8//-16
            let barButton = UIBarButtonItem(image: name, style: .done, target: self, action: #selector(mo_dismissViewController(tap:)))
            return [spaceItem, barButton]
        }()
    }
}
