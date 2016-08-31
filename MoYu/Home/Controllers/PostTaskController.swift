//
//  PostTaskController.swift
//  MoYu
//
//  Created by Chris on 16/8/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PostTaskController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发布任务"
        
        self.addRightNavigationButton(title: "发布")
        self.rightButtonClourse = { [unowned self] in
            self.handleRightButtonTap()
        }
        
        self.setupView()
    }
    
    //MARK: - public method
    @objc private func handleRightButtonTap(){
        
        self.view.endEditing(true)
        
        if taskModel.name.isEmpty {
            self.show(message: "标题不能为空~")
            return
        }
        
        if taskModel.commission == 0{
            self.show(message: "金额不能为空~")
            return
        }
        
        if taskModel.type < 0{
            self.show(message: "请选择任务类型~")
            return
        }
        
        if taskModel.sum < 0{
            self.show(message: "订单数量不能为空")
        }
        
        
        if taskModel.address.isEmpty{
            self.show(message: "web 地址不能为空~")
            return
        }
        
        if taskModel.step.isEmpty{
            self.show(message: "还未填写任务步骤~")
            return
        }
        
        if taskModel.content.isEmpty{
            self.show(message: "还未填写任务内容~")
        }
        
        Router.postTask(paramter: taskModel.combination()).request { (status, json) in
            
            self.show(error: status, showSuccess: true)
            
            if case .success = status{
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
    
    //MARK: - var & let
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.mo_background()
        return tableView
    }()
    
    private let cellPrompts = [["请在此输入标题"],
                               ["类别","金额","订单数"],
                               ["请在此输入web地址","请在此输入详细步骤", "请在此输入内容"]]
    private let taskTypeDetail = ["用户体验调查", "问卷调查", "其他"]
    
    lazy var taskTypeAction:ActionSheetController = {
        let actionSheet = ActionSheetController()
        actionSheet.delegate = self
        actionSheet.showCancelButton = false
        actionSheet.showDestructiveButton = false
        return actionSheet
    }()
    
    lazy var amountPrompt = PromptController.instance(title: "金额", confirm: "提交", configClourse: {
        (textfield:UITextField) ->Int in
        textfield.placeholder = "请输入支付的金额"
        textfield.keyboardType = .DecimalPad
        return 6
    })
    
    lazy var sumPrompt = PromptController.instance(title: "订单数", confirm: "提交", configClourse: {
        (textfield:UITextField) ->Int in
        textfield.placeholder = "请输入订单总数"
        textfield.keyboardType = .NumberPad
        return 4
    })
    
    
    var taskModel = PostTaskModel()
}

// MARK: - UITableViewDelegate
extension PostTaskController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0...1,_):
            return 44
        case (2,0):
            return 60
        default:
            return 140
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        func cellForText(placeholder:String, maxLength:Int,clourse:(String->Void)){
            guard let cell = cell as? PublishTaskCell else{ return }
            cell.update(placeholder, maxLength: maxLength, clourse: clourse)
        }
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            cellForText(cellPrompts[0][0], maxLength: 40){
                self.taskModel.name = $0
            }
        
        case (1,0):
            cell.textLabel?.text = cellPrompts[1][0]
            if taskModel.type < 0{
                cell.detailTextLabel?.text = "请选择"
            }else{
                cell.detailTextLabel?.text = taskTypeDetail[taskModel.type]
            }
            
        case (1, 1):
            cell.textLabel?.text = cellPrompts[1][1]
            if taskModel.commission > 0{
                cell.detailTextLabel?.text = "\(taskModel.commission)元/次"
            }else{
                cell.detailTextLabel?.text = "请选择"
            }
            
        case (1,2):
            cell.textLabel?.text = cellPrompts[1][2]
            if taskModel.sum == 0{
                cell.detailTextLabel?.text = "请选择"
            }else{
                cell.detailTextLabel?.text = "\(taskModel.sum) "
            }
            
        case (2,0):
            cellForText(cellPrompts[2][0], maxLength: 128){
                self.taskModel.address = $0
            }
        case (2,1):
            cellForText(cellPrompts[2][1], maxLength: 200){
                self.taskModel.step = $0
            }
        case (2,2):
            cellForText(cellPrompts[2][2], maxLength: 200){
                self.taskModel.content = $0
            }
            
        default: break
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        switch (indexPath.section, indexPath.row) {
        case (1,0):
            taskTypeAction.show(self)
        case (1,1):
            amountPrompt.show(self)
            amountPrompt.confirmClourse = { [unowned self] in
                guard let amount = Double($0) else{ return }
                
                self.taskModel.commission = amount
                self.tableView.reloadData()
            }
        case (1,2):
            sumPrompt.show(self)
            sumPrompt.confirmClourse = {[unowned self] in
                guard let sum = Int($0) else{return }
                self.taskModel.sum = sum
                self.tableView.reloadData()
            }
        default:break
        }
        
    }
    
}

// MARK: - UITableViewDataSource
extension PostTaskController: UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellPrompts.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellPrompts[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        func defaultCell()->UITableViewCell{
            let cellId = "postTaskIdentifier"
            guard let cell = tableView.dequeueReusableCellWithIdentifier(cellId) else{
                return UITableViewCell(style: .Value1, reuseIdentifier: cellId)
            }
            return cell
        }
        
        switch (indexPath.section, indexPath.row) {
        case (0,0),(2,_):
            return PublishTaskCell.cell(tableView: tableView)
        case(1, 0...2 ):
            let cell =  defaultCell()
            cell.textLabel?.font = UIFont.mo_font()
            cell.textLabel?.textColor = UIColor.mo_lightBlack()
            cell.detailTextLabel?.font = UIFont.mo_font()
            cell.detailTextLabel?.textColor = UIColor.mo_silver()
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

// MARK: - ActionSheetProtocol
extension PostTaskController: ActionSheetProtocol{
    
    func otherButtons(sheet sheet:ActionSheetController)->[String]{
        
        return taskTypeDetail
    }
    
    func action(sheet sheet: ActionSheetController, selectedAtIndex: Int){
        
        self.taskModel.type = selectedAtIndex
        self.tableView.reloadData()
    }
}



