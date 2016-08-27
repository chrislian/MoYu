//
//  DatePickerController.swift
//  MoYu
//
//  Created by Chris on 16/8/27.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Spring

class DatePickerController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        self.view.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3 )
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.animation = "slideUp"
        contentView.animate()
    }
    
    //MARK: - evnet reponse
    
    @objc private func buttonTap(cancel sender:UIButton){
        
        self.dismiss()
    }
    
    @objc private func buttonTap(submit sender: UIButton){
        
        self.submitClourse?(datePicker.date)
        self.dismiss()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.dismiss()
    }
    
    //MARK: - public method
    func show(inViewController:UIViewController, date:NSDate? = nil){
        self.modalPresentationStyle = .OverCurrentContext
        let vc = inViewController.view.window?.rootViewController
        vc?.presentViewController(self, animated: false, completion: nil)
        
        if let date = date{
            self.datePicker.setDate(date, animated: true)
        }
    }
    

    
    
    //MARK: - private method
    private func dismiss(){
        
        self.view.backgroundColor = UIColor.clearColor()

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func setupView(){
        
        self.view.addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
        }
        
        contentView.addSubview(datePicker)
        datePicker.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(contentView)
        }
        

        contentView.addSubview(cancelButton)
        cancelButton.snp_makeConstraints { (make) in
            make.left.top.equalTo(contentView)
            make.bottom.equalTo(datePicker.snp_top)
            make.width.equalTo(60)
        }
        
        contentView.addSubview(submitButton)
        submitButton.snp_makeConstraints { (make) in
            make.right.top.equalTo(contentView)
            make.bottom.equalTo(datePicker.snp_top)
            make.width.equalTo(cancelButton)
            make.left.greaterThanOrEqualTo(cancelButton.snp_right).offset(5)
        }
    }
    
    
    //MARK: - var & let
    
    private lazy var contentView: SpringView = {
        let view = SpringView()
        view.backgroundColor = UIColor.mo_background()
        return view
    }()
    
    private lazy var datePicker:UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .DateAndTime
        date.minimumDate = NSDate()
        return date
    }()
    
    private lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("取消", forState: .Normal)
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font()
        button.addTarget(self, action: #selector(DatePickerController.buttonTap(cancel:)), forControlEvents: .TouchUpInside)
        return button
    }()
    
    private lazy var submitButton:UIButton = {
        let button = UIButton()
        button.setTitle("确定", forState: .Normal)
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font()
        button.addTarget(self, action: #selector(DatePickerController.buttonTap(submit:)), forControlEvents: .TouchUpInside)
        return button
    }()
    
    var submitClourse:(NSDate->Void)?
}
