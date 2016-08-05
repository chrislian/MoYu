//
//  BaseController.swift
//  MoYu
//
//  Created by Chris on 16/7/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SVProgressHUD

enum NavButtonDirectionType: Int{
    case Left = 0,Right
}

public typealias NavigationButtonClourse = () -> Void

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let nav = self.navigationController where nav.viewControllers.count > 1{
            let spaceItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil , action: nil)
            spaceItem.width = -8
            self.navigationItem.setLeftBarButtonItems([spaceItem,UIBarButtonItem(customView:leftNavigationButton)], animated: true)
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationBarOpaque = true
    }
    
    
    // MARK: private func
    @objc private func navigationButtonClicked(sender:UIButton) {
        if sender === self.leftNavigationButton{
            if let closure = self.leftButtonClourse{
                closure()
            }else{
                navigationController?.popViewControllerAnimated(true)
            }
        }else if sender == self.rightNavigationButton{
            self.rightButtonClourse?()
        }
    }
    
    //MARK: public method
    
    /**
     添加返回按钮
     */
    func addBackNavigationButton(){
        self.setLeftNavigationButton(nomal: UIImage(named: "tab_fanhui_a_"), highlighted: UIImage(named: "tab_fanhui_b_"))
        self.leftButtonClourse = {[unowned self] in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func setNavigation(title text:String, textColor:UIColor = UIColor.mo_lightBlack()) {
        navigationTitleLable.text = text
        navigationTitleLable.textColor = textColor
    }

    func setLeftNavigationButton(nomal image:UIImage?,highlighted:UIImage?,size:CGSize = CGSize(width: 20, height: 32)){

        leftNavigationButton = createButton(nomal: image, highlighted: highlighted,size: size)
        setLeftBar(button:leftNavigationButton)
    }
    func setLeftNavigationButton(attributedString text:NSAttributedString){

        leftNavigationButton = createButton(attributedString: text)
        setLeftBar(button:leftNavigationButton)
    }

    func setRightNavigationButton(nomal image:UIImage?,highlighted:UIImage?,size:CGSize = CGSize(width: 20, height: 32)){
        
        if rightNavigationButton != nil {
            rightNavigationButton = nil
        }
        rightNavigationButton = createButton(nomal: image, highlighted: highlighted,size: size)
        setRightBar(button:rightNavigationButton!)
    }
    
    func setRightNavigationButton(attributedString text:NSAttributedString){
        
        if rightNavigationButton != nil {
            rightNavigationButton = nil
        }
        rightNavigationButton = createButton(attributedString:text)
        setRightBar(button:rightNavigationButton!)
    }
    
    // MARK: pravate func
    private func createButton(attributedString text:NSAttributedString)->UIButton{
        let button             = UIButton(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        button.backgroundColor = UIColor.clearColor()
        var buttonSize           = text.boundingRectWithSize(CGSize(width: 0, height: 44),options: [.UsesFontLeading,.UsesLineFragmentOrigin], context: nil).size
        if buttonSize.width > 100 {
            buttonSize.width = 100
        }
        button.frame           = CGRect(x: 0, y: 0, width: buttonSize.width+4, height: 44)
        button.setAttributedTitle(text, forState: .Normal)
        button.addTarget(self, action: #selector(BaseController.navigationButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        return button
    }
    
    private func createButton(nomal image:UIImage?,highlighted:UIImage?,size:CGSize = CGSizeZero)->UIButton {
        let button                 = UIButton()
        if CGSizeEqualToSize(size, CGSizeZero) {
            if let noramlImage = image {
                button.frame = CGRect(x: 0, y: 0, width: noramlImage.size.width*30/noramlImage.size.height, height: 30)
            } else {
                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            }
            
        } else {
            button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        
        button.backgroundColor = UIColor.clearColor();
        button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3)
        button.setImage(image, forState: .Normal)
        button.setImage(highlighted, forState: .Highlighted)
        button.contentMode = .Center
        button.addTarget(self, action: #selector(BaseController.navigationButtonClicked(_:)), forControlEvents: .TouchUpInside)
        button.setTitleColor(UIColor.mo_lightBlack(), forState: UIControlState.Normal)
        return button
    }
    
    private func setLeftBar(button left:UIButton){
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        spaceItem.width = -8
        navigationItem.setLeftBarButtonItems([spaceItem,UIBarButtonItem(customView: left)], animated: false)
    }
    private func setRightBar(button right:UIButton){
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        spaceItem.width = -8
        navigationItem.setRightBarButtonItems([spaceItem,UIBarButtonItem(customView: right)], animated: false)
    }

    //MARK: - var & let
    
    private lazy var navigationTitleLable: UILabel = {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        label.backgroundColor = UIColor.clearColor()
        label.textColor       = UIColor.mo_lightBlack()
        label.font            = UIFont.mo_boldFont(.bigger)
        label.textAlignment   = .Center
        self.navigationItem.titleView  = label
        return label
    }()
    
    private lazy var leftNavigationButton: UIButton = {
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 21, height: 30))
        button.backgroundColor = UIColor.clearColor()
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        button.setImage(UIImage(named: "tab_fanhui_a_"), forState: .Normal)
        button.setImage(UIImage(named: "tab_fanhui_b_"), forState: .Highlighted)
        button.contentMode = .Center
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.addTarget(self, action: #selector(BaseController.navigationButtonClicked(_:)), forControlEvents: .TouchUpInside)
        return button
    }()
    
    private var rightNavigationButton: UIButton?
    
    
    //MARK: - public var
    var leftButtonClourse: NavigationButtonClourse?
    var rightButtonClourse: NavigationButtonClourse?
    
    var navigationBarOpaque:Bool = false{
        didSet{
            if navigationBarOpaque{
                self.navigationController?.navigationBar.setBackgroundImage( UIImage.mo_createImageWithColor(UIColor.mo_main()), forBarMetrics: .Default)
                self.navigationController?.navigationBar.shadowImage = UIImage.mo_createImageWithColor(UIColor.mo_silver())
//                self.navigationController?.navigationBar.translucent = false
            }else{
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
//                self.navigationController?.navigationBar.translucent = true
            }
        }
    }
}

