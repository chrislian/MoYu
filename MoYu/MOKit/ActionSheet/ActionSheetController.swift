//
//  ActionSheetController.swift
//  meiqu
//
//  Created by chris on 16/8/2.
//  Copyright © 2016年 com.moyu.com. All rights reserved.
//

import UIKit
import Spring

@objc protocol ActionSheetProtocol:class{
    
    @objc optional func config(sheet:ActionSheetController, destrutiveButton: UIButton)
    @objc optional func config(sheet:ActionSheetController, cancelButton: UIButton)
    
    @objc optional func otherButtons(sheet:ActionSheetController)->[String]
    @objc optional func action(sheet: ActionSheetController, selectedAtIndex: Int)
}

private let buttonHeight:CGFloat = 36
class ActionSheetController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        springView.transform = CGAffineTransform(translationX: 0, y: 270)
        self.view.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.45 )
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadButton()
        super.viewDidAppear(animated)
        springView.animation = "slideUp"
        springView.animate()
    }
    deinit{
        println("action sheet deinit")
    }
    // MARK: public fun
    func show(_ vc:UIViewController){
        if self.presentingViewController == nil {
            self.modalPresentationStyle = .custom
            vc.present(self, animated: false, completion: nil)
        } else {
            dismiss()
        }
    }
    
    func dismiss(_ completion: (() -> Void)? = nil){
        if self.presentingViewController != nil {
            springView.animation = "slideUp"
            springView.animateTo()
            let delayInSeconds = 0.2
            let popTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime) { () -> Void in
                self.dismiss(animated: false, completion: completion)
            }
        }
    }
    // MARK: private func
    fileprivate func loadButton(){
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        for view in springView.subviews {
            view.removeFromSuperview()
        }
        self.view.addSubview(springView)
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        self.view.addSubview(shadeView)
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .bottom, relatedBy: .equal, toItem: springView, attribute: .top, multiplier: 1, constant: 0))
        
        let buttons = getButtons()
        let viewHeight = 10 + CGFloat(buttons.count)*(buttonHeight+10.0)
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: viewHeight))
        
        for button in buttons {
            if button.superview != nil {
                button.removeFromSuperview()
            }
            springView.addSubview(button)
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: springView, attribute: .left, multiplier: 1, constant: 15))
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: springView, attribute: .right, multiplier: 1, constant: -15))
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: buttonHeight))
            let top = 10 + CGFloat(button.buttonIndex)*(buttonHeight + 10)
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: springView, attribute: .top, multiplier: 1, constant: top))
        }
    }
    @objc fileprivate func buttonAction(_ button:UIButton){
        dismiss { 
            guard let button = button as? ActionSheetButton else{ return }
            
            self.delegate?.action?(sheet: self, selectedAtIndex: Int(button.buttonIndex) )
        }
    }
    
    fileprivate func getButtons()->[ActionSheetButton] {
        var buttons = [ActionSheetButton]()
        var index:UInt = 0
        
        let otherCount = self.delegate?.otherButtons?(sheet : self).count ?? 0
        
        if showDestructiveButton || otherCount == 0{
        
            buttons.append(destructiveButton)
            destructiveButton.buttonIndex = index
            self.delegate?.config?(sheet: self, destrutiveButton: destructiveButton)
            index += 1
        }
        
        if let otherButtons = self.delegate?.otherButtons?(sheet : self) {
            for text in otherButtons {
                let button = otherButton()
                button.setTitle(text, for: UIControlState())
                button.buttonIndex = index
                index += 1
                buttons.append(button)
            }
        }

        if showCancelButton || otherCount == 0{
            cancelButton.buttonIndex = index
            self.delegate?.config?(sheet: self, cancelButton: cancelButton)
            buttons.append(cancelButton)
        }

        return buttons
    }
    
    fileprivate func otherButton()->ActionSheetButton {
        let button = ActionSheetButton()
        button.backgroundColor     = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius  = 5
        button.setTitleColor(UIColor.gray, for: UIControlState())
        button.layer.masksToBounds = true
        button.layer.borderWidth   = 0.65
        button.addTarget(self, action: #selector(ActionSheetController.buttonAction(_:)), for: .touchUpInside )
        button.layer.borderColor   = UIColor.mo_mercury().cgColor
        return button
    }
    
    @objc fileprivate func tapBackgroundGesture(_ gesture:UIGestureRecognizer){
        dismiss()
    }
    
    // MARK: public var
    weak var delegate:ActionSheetProtocol?
    var storeInfo:AnyObject? = nil
    
    var showCancelButton = true
    var showDestructiveButton = true
    // MARK: private var
   
    fileprivate lazy var destructiveButton:ActionSheetButton = {
        let button = ActionSheetButton()
        button.backgroundColor     = UIColor.mo_main()
        button.layer.cornerRadius  = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ActionSheetController.buttonAction(_:)), for: .touchUpInside )
        button.setTitle("确认", for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        return button
    }()
    
    fileprivate lazy var cancelButton:ActionSheetButton = {
        let button = ActionSheetButton()
        button.backgroundColor     = UIColor.gray
        button.layer.cornerRadius  = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ActionSheetController.buttonAction(_:)), for: .touchUpInside )
        button.setTitle("取消", for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        return button
    }()
    
    
    fileprivate lazy var springView:SpringView = {
        let view = SpringView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate lazy var shadeView:UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(self.gesture)
        return view
    }()
    
    fileprivate lazy var gesture:UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ActionSheetController.tapBackgroundGesture(_:)))
        
        return gesture
    }()
    
    fileprivate class ActionSheetButton:UIButton {
        var buttonIndex:UInt = 0
    }
}
