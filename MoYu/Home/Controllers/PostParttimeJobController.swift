//
//  PostParttimeJobController.swift
//  MoYu
//
//  Created by Chris on 16/8/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PostParttimeJobController: UIViewController,PraseErrorType,AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "发布兼职")
        
        self.setupView()
    }

    //MARK: - event response
    dynamic fileprivate func nextButtonClicked(_ sender:UIButton){
        
        if postModel.type == 0{
            self.showAlert(message: "工作种类还没有选择哦~")
            return
        }
        
        if postModel.time.mo_isYesterday(){
            self.showAlert(message: "工作时间还未选择哦~")
            return
        }
        
        if postModel.commission == 0{
            self.showAlert(message: "金额还未设置哦~")
            return
        }
        
        if postModel.workingtime == 0{
            self.showAlert(message: "工时还未设置哦~")
            return
        }
        
        let vc = PostPartimeJobDetailController()
        vc.postModel = postModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
        }
        
        self.view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-10)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
    }
    
    //MARK: - var & let

    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.rowHeight = 44.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.mo_background()
        return tableView
    }()
    
    fileprivate lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("下一步", for: UIControlState())
        button.setTitleColor(UIColor.mo_lightBlack(), for: UIControlState())
        button.titleLabel?.font = UIFont.mo_font(.bigger)
        button.backgroundColor = UIColor.mo_main()
        button.layer.borderColor = UIColor.mo_lightBlack().cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(PostParttimeJobController.nextButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var categoryTypeAction:ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
    
    lazy var sexTypeAction:ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
    
    lazy var employeePrompt = PromptController.instance(title: "人数", confirm: "提交", configClourse: {
        (textfield:UITextField) ->Int in
        textfield.placeholder = "请输入需要的人数"
        textfield.keyboardType = .numberPad
        return 2
    })
    
    lazy var professionPrompt = PromptController.instance(title: "专业", confirm: "提交") {
        (textfield:UITextField) -> Int in
        textfield.placeholder = "请输入专业限制"
        return 20
    }
    
    lazy var educationPrompt = PromptController.instance(title: "学历", confirm: "提交") {
        (textfield: UITextField) -> Int in
        textfield.placeholder = "请输入最低要求学历"
        return 10
    }
    
    lazy var commissionPrompt = PromptController.instance(title: "金额", confirm: "提交") {
        (textfield:UITextField) -> Int in
        textfield.placeholder = "请输入支付每份工作的的金额"
        textfield.keyboardType = .decimalPad
        return 6
    }
    
    lazy var taskTimePrompt = PromptController.instance(title: "金额", confirm: "提交") {
        (textfield:UITextField) -> Int in
        textfield.placeholder = "请输入每份工作的工时"
        textfield.keyboardType = .decimalPad
        return 3
    }
    
    var datePickerController = DatePickerController()
    
    fileprivate let dataArrays = [["种类","时间", "人数"], ["性别", "专业", "学历"], ["金额", "工时"]]
    
    lazy fileprivate var catetoryTypeInfo = ["餐厅" ,"日薪" ,"模特" ,"派单" ,"服务员" ,"促销" ,"客服" ,"麦当劳"]
    
    lazy fileprivate var sexTypeInfo = ["不限", "女", "男"]
    
    lazy fileprivate var postModel = PostPartTimeJobModel()
    
    var location:MoYuLocation{
        set(newValue){
            postModel.latitude = newValue.latitude
            postModel.longitude = newValue.longitude
        }
        get{
            return MoYuLocation(latitude: postModel.latitude, longitude: postModel.longitude)
        }
    }
}

//MARK: - UITableView delegate
extension PostParttimeJobController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.textLabel?.text = dataArrays[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        
        cell.detailTextLabel?.font = UIFont.mo_font()
        cell.detailTextLabel?.textColor = UIColor.mo_silver()
        
        var detailText = ""
        switch((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row){
        case (0,0)://类型
            if postModel.type == 0{
                detailText = "请选择"
            }else{
                detailText = catetoryTypeInfo[postModel.type - 1]
            }
        case (0,1):
            if postModel.time.mo_isYesterday(){
                detailText = "请选择"
            }else{
                detailText = Date.mo_stringFromDatetime2( postModel.time )
            }
            
        case (0,2)://人数
            if postModel.sum == 0{
                detailText = "不限"
            }else{
                detailText = "\(postModel.sum)人"
            }
        case (1,0):
            detailText = sexTypeInfo[postModel.sex]
        case (1,1):
            detailText = postModel.profession
        case (1,2):
            detailText = postModel.education
        case (2,0):
            detailText = String(format: "%.2f元", postModel.commission)
        case (2,1):
            detailText = String(format: "%.1f小时", postModel.workingtime)
            
        default: break
        }
        cell.detailTextLabel?.text = detailText

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            categoryTypeAction.show(self)
        case (0,1):
            var date = postModel.time
            if postModel.time.mo_isYesterday(){
                date = Date().mo_dateByAddingDays(1)
            }
            datePickerController.show(self,date: date)
            datePickerController.submitClourse = { [unowned self] in
                self.postModel.time = $0
                self.tableView.reloadData()
            }
        case (0,2):
            employeePrompt.show(self)
            employeePrompt.confirmClourse = { [unowned self] in
                if let sum = Int($0) {
                    self.postModel.sum = sum
                    self.tableView.reloadData()
                }
            }
            
        case (1,0):
            sexTypeAction.show(self)
        case (1,1):
            professionPrompt.show(self)
            professionPrompt.confirmClourse = { [unowned self] in
                if $0.isEmpty{
                    self.postModel.profession = "不限"
                }else{
                    self.postModel.profession = $0
                }
                self.tableView.reloadData()
            }
        case (1,2):
            educationPrompt.show(self)
            educationPrompt.confirmClourse = { [unowned self] in
                if $0.isEmpty{
                    self.postModel.education = "不限"
                }else{
                    self.postModel.education = $0
                }
                self.tableView.reloadData()
            }
            
        case (2,0):
            commissionPrompt.show(self)
            commissionPrompt.confirmClourse = { [unowned self] in
                if let value = Double($0) , !$0.isEmpty{
                    self.postModel.commission = value
                }else{
                    self.postModel.commission = 0
                }
                self.tableView.reloadData()
            }
        case (2,1):
            taskTimePrompt.show(self)
            taskTimePrompt.confirmClourse = { [unowned self] in
                if let value = Double($0) , !$0.isEmpty{
                    self.postModel.workingtime = value
                }else{
                    self.postModel.workingtime = 0
                }
                self.tableView.reloadData()
            }
            
        default:
            break
        }
    }
}

// MARK: - UITableView DataSource
extension PostParttimeJobController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArrays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrays[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "postTimeJobIdentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else{
            return UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        return cell

    }
}

extension PostParttimeJobController: ActionSheetProtocol{
    
    func otherButtons(sheet:ActionSheetController)->[String]{
        
        if sheet == categoryTypeAction{
            return catetoryTypeInfo
        }else if sheet == sexTypeAction{
            return sexTypeInfo
        }
        
        return []
    }
    
    func action(sheet: ActionSheetController, selectedAtIndex: Int){
        
        if sheet === categoryTypeAction{
            postModel.type = selectedAtIndex + 1
        }else if sheet === sexTypeAction{
            postModel.sex = selectedAtIndex
        }
        self.tableView.reloadData()
    }
}
