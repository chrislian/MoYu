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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5 )
        
        contentView.animation = "slideUp"
        contentView.animate()
    }
    
    //MARK: - evnet reponse
    
    @objc fileprivate func buttonTap(cancel sender:UIButton){
        
        self.dismiss()
    }
    
    @objc fileprivate func buttonTap(submit sender: UIButton){
        
        self.submitClourse?(datePicker.date)
        self.dismiss()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.dismiss()
    }
    
    //MARK: - public method
    func show(_ inViewController:UIViewController, date:Date? = nil){
        self.modalPresentationStyle = .overCurrentContext
        let vc = inViewController.view.window?.rootViewController
        vc?.present(self, animated: false, completion: nil)
        
        if let date = date{
            self.datePicker.setDate(date, animated: true)
        }
    }
    

    
    
    //MARK: - private method
    fileprivate func dismiss(){
        
        self.view.backgroundColor = UIColor.clear

        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupView(){
        
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
        }
        
        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(contentView)
        }
        

        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView)
            make.bottom.equalTo(datePicker.snp.top)
            make.width.equalTo(60)
        }
        
        contentView.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.right.top.equalTo(contentView)
            make.bottom.equalTo(datePicker.snp.top)
            make.width.equalTo(cancelButton)
            make.left.greaterThanOrEqualTo(cancelButton.snp.right).offset(5)
        }
    }
    
    
    //MARK: - var & let
    
    fileprivate lazy var contentView: SpringView = {
        let view = SpringView()
        view.backgroundColor = UIColor.mo_background
        return view
    }()
    
    fileprivate lazy var datePicker:UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .dateAndTime
        date.minimumDate = Date()
        return date
    }()
    
    fileprivate lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: UIControlState())
        button.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
        button.titleLabel?.font = UIFont.mo_font()
        button.addTarget(self, action: #selector(DatePickerController.buttonTap(cancel:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var submitButton:UIButton = {
        let button = UIButton()
        button.setTitle("确定", for: UIControlState())
        button.setTitleColor(UIColor.mo_lightBlack, for: UIControlState())
        button.titleLabel?.font = UIFont.mo_font()
        button.addTarget(self, action: #selector(DatePickerController.buttonTap(submit:)), for: .touchUpInside)
        return button
    }()
    
    var submitClourse:((Date)->Void)?
}
