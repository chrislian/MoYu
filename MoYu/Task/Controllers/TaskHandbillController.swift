//
//  TaskHandbillController.swift
//  MoYu
//
//  Created by Chris on 16/9/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class TaskHandbillController: UIViewController,PraseErrorType,AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "兼职详情")
        
        setupView()
        
        updateTaskButton(status: taskModel?.status ?? 0)
    }

    //MARK: - event response
    @IBAction func taskButtonTap(sender: UIButton) {
        
        guard let model = taskModel else{ return }
        
        Router.postPartTimeStatus(order: model.ordernum, status: sender.tag).request { (status, json) in
            
            self.show(error: status, showSuccess: true)
            
            if case .success = status, let json = json{
                
                let model = TaskModel(json:json)
                self.taskModel = model
                self.updateTaskButton(status: model.status)
            }
        }
    }
    
    //MARK: - private methods
    
    private func updateTaskButton(status status:Int){
        
        taskButton.tag = status
        if status == 0 {
            taskButton.backgroundColor = UIColor.mo_main()
            taskButton.setTitle("开始任务", forState: .Normal)
            taskButton.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
            taskButton.enabled = true
        }else if status == 1{
            taskButton.backgroundColor = UIColor.mo_main()
            taskButton.setTitle("确认完成", forState: .Normal)
            taskButton.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
            taskButton.enabled = true
        }else if status == 2{
            taskButton.backgroundColor = UIColor.grayColor()
            taskButton.setTitle("等待商家确认", forState: .Normal)
            taskButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            taskButton.enabled = false
        }
    }
    
    private func setupView(){
        
        tableView.backgroundColor = UIColor.mo_background()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: String(TaskDetailCell),bundle: nil), forCellReuseIdentifier: TaskDetailCell.identifier)
        tableView.registerClass(TaskStepDetailCell.self, forCellReuseIdentifier: TaskStepDetailCell.identifier)
    }
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskButton: UIButton!
    
    var taskModel :TaskModel?
}

// MARK: - UITableViewDelegate
extension TaskHandbillController: UITableViewDelegate{

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0.01
        }
        return 30.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        func headerLabel(title:String)->UILabel{
            let label = UILabel()
            label.text = "  " + title
            label.textColor = UIColor.mo_lightBlack()
            label.font = UIFont.mo_font()
            return label
        }
        
        if section == 1{
            return headerLabel("内容")
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 80
        default:
            return 200
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.selectionStyle = .None
        
        if let cell = cell as? TaskDetailCell, model = taskModel {
            cell.update(item: model, onlyContent:true)
        }else if let cell = cell as? TaskStepDetailCell, model = taskModel{
            cell.update(model: model, isStep: false)
        }
    }
}

// MARK: - UITableViewDataSource
extension TaskHandbillController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return TaskDetailCell.cell(tableView: tableView)
        default:
            return TaskStepDetailCell.cell(tableView: tableView)
        }
    }
}