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
    
    optional func config(sheet sheet:ActionSheetController, destrutiveButton: UIButton)
    optional func config(sheet sheet:ActionSheetController, cancelButton: UIButton)
    
    optional func otherButtons(sheet sheet:ActionSheetController)->[String]
    optional func action(sheet sheet: ActionSheetController, selectedAtIndex: Int)
}

private let buttonHeight:CGFloat = 36
class ActionSheetController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        springView.transform = CGAffineTransformMakeTranslation(0, 270)
        self.view.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.45 )
        
    }
    override func viewDidAppear(animated: Bool) {
        loadButton()
        super.viewDidAppear(animated)
        springView.animation = "slideUp"
        springView.animate()
    }
    deinit{
        println("action sheet deinit")
    }
    // MARK: public fun
    func show(vc:UIViewController){
        if self.presentingViewController == nil {
            self.modalPresentationStyle = .Custom
            vc.presentViewController(self, animated: false, completion: nil)
        } else {
            dismiss()
        }
    }
    
    func dismiss(completion: (() -> Void)? = nil){
        if self.presentingViewController != nil {
            springView.animation = "slideUp"
            springView.animateTo()
            let delayInSeconds = 0.2
            let popTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                self.dismissViewControllerAnimated(false, completion: completion)
            }
        }
    }
    // MARK: private func
    private func loadButton(){
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        for view in springView.subviews {
            view.removeFromSuperview()
        }
        self.view.addSubview(springView)
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0))
        self.view.addSubview(shadeView)
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: shadeView, attribute: .Bottom, relatedBy: .Equal, toItem: springView, attribute: .Top, multiplier: 1, constant: 0))
        
        let buttons = getButtons()
        let viewHeight = 10 + CGFloat(buttons.count)*(buttonHeight+10.0)
        self.view.addConstraint(NSLayoutConstraint(item: springView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: viewHeight))
        
        for button in buttons {
            if button.superview != nil {
                button.removeFromSuperview()
            }
            springView.addSubview(button)
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: springView, attribute: .Left, multiplier: 1, constant: 15))
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: springView, attribute: .Right, multiplier: 1, constant: -15))
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: buttonHeight))
            let top = 10 + CGFloat(button.buttonIndex)*(buttonHeight + 10)
            springView.addConstraint(NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: springView, attribute: .Top, multiplier: 1, constant: top))
        }
    }
    @objc private func buttonAction(button:UIButton){
        dismiss { 
            guard let button = button as? ActionSheetButton else{ return }
            
            self.delegate?.action?(sheet: self, selectedAtIndex: Int(button.buttonIndex) )
        }
    }
    
    private func getButtons()->[ActionSheetButton] {
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
                button.setTitle(text, forState: .Normal)
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
    
    private func otherButton()->ActionSheetButton {
        let button = ActionSheetButton()
        button.backgroundColor     = UIColor.whiteColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius  = 5
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.layer.masksToBounds = true
        button.layer.borderWidth   = 0.65
        button.addTarget(self, action: #selector(ActionSheetController.buttonAction(_:)), forControlEvents: .TouchUpInside )
        button.layer.borderColor   = UIColor.mo_mercury().CGColor
        return button
    }
    
    @objc private func tapBackgroundGesture(gesture:UIGestureRecognizer){
        dismiss()
    }
    
    // MARK: public var
    weak var delegate:ActionSheetProtocol?
    var storeInfo:AnyObject? = nil
    
    var showCancelButton = true
    var showDestructiveButton = true
    // MARK: private var
   
    private lazy var destructiveButton:ActionSheetButton = {
        let button = ActionSheetButton()
        button.backgroundColor     = UIColor.mo_main()
        button.layer.cornerRadius  = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ActionSheetController.buttonAction(_:)), forControlEvents: .TouchUpInside )
        button.setTitle("确认", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        return button
    }()
    
    private lazy var cancelButton:ActionSheetButton = {
        let button = ActionSheetButton()
        button.backgroundColor     = UIColor.grayColor()
        button.layer.cornerRadius  = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ActionSheetController.buttonAction(_:)), forControlEvents: .TouchUpInside )
        button.setTitle("取消", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        return button
    }()
    
    
    private lazy var springView:SpringView = {
        let view = SpringView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    private lazy var shadeView:UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clearColor()
        view.userInteractionEnabled = true
        view.addGestureRecognizer(self.gesture)
        return view
    }()
    
    private lazy var gesture:UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ActionSheetController.tapBackgroundGesture(_:)))
        
        return gesture
    }()
    
    private class ActionSheetButton:UIButton {
        var buttonIndex:UInt = 0
    }
}
