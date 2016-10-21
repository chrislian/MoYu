//
//  TaskAppTestController.swift
//  MoYu
//
//  Created by Chris on 16/9/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

final class TaskAppTestController: UIViewController,PraseErrorType,AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "任务详情")
        
        setupView()
        
//        updateTaskButton(status: taskModel?.status ?? 0)
        self .checkOrderStatus()
    }
    
    //MARK: - event response
    @IBAction func taskButtonTap(_ sender: UIButton) {
        
        guard let model = taskModel else{ return }
        
        Router.postTaskStatus(order: model.ordernum, status: sender.tag).request { (status, json) in
            
            self.show(error: status, showSuccess: true)
            
            if case .success = status, let json = json{
                
                let model = TaskModel(json:json)
                self.taskModel = model
                self.updateTaskButton(status: model.status)
            }
        }
    }
    
    //MARK: - private methods
    private func checkOrderStatus(){
        
        guard let orderId = taskModel?.ordernum else{ return }
        
        Router.checkTaskStatus(order: orderId).request { (status, json) in
            self.show(error: status)
            if case .success = status, let json = json{
                let orderStatus = json["status"].intValue
                self.updateTaskButton(status: orderStatus)
            }
        }
    }
    
    private func updateTaskButton(status:Int){
        
        taskButton.tag = status
        if status == 0 {
            taskButton.backgroundColor = UIColor.mo_main()
            taskButton.setTitle("开始任务", for: .normal)
            taskButton.setTitleColor(UIColor.mo_lightBlack(), for: .normal)
            taskButton.isEnabled = true
        }else if status == 1{
            taskButton.backgroundColor = UIColor.mo_main()
            taskButton.setTitle("确认完成", for: .normal)
            taskButton.setTitleColor(UIColor.mo_lightBlack(), for: .normal)
            taskButton.isEnabled = true
        }else if status == 2{
            taskButton.backgroundColor = UIColor.gray
            taskButton.setTitle("等待商家确认", for: .normal)
            taskButton.setTitleColor(UIColor.white, for: .normal)
            taskButton.isEnabled = false
        }
    }
    
    private func setupView(){
        
        tableView.backgroundColor = UIColor.mo_background()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: String(describing: TaskDetailCell.self),bundle: nil), forCellReuseIdentifier: TaskDetailCell.identifier)
        tableView.register(TaskStepDetailCell.self, forCellReuseIdentifier: TaskStepDetailCell.identifier)
    }
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskButton: UIButton!
    
    var taskModel :TaskModel?
}

// MARK: - UITableViewDelegate
extension TaskAppTestController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0.01
        }
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        func headerLabel(_ title:String)->UILabel{
            let label = UILabel()
            label.text = "  " + title
            label.textColor = UIColor.mo_lightBlack()
            label.font = UIFont.mo_font()
            return label
        }
        
        if section == 1{
            return headerLabel("步骤")
        }else if section == 2{
            return headerLabel("内容")
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch (indexPath as NSIndexPath).section {
        case 0:
            return 80
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.selectionStyle = .none
        
        if let cell = cell as? TaskDetailCell, let model = taskModel {
            cell.update(item: model, onlyContent:true)
        }else if let cell = cell as? TaskStepDetailCell, let model = taskModel{
            if (indexPath as NSIndexPath).section == 1{
                cell.update(model: model, isStep: true)
            }else{
                cell.update(model: model, isStep: false)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TaskAppTestController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as NSIndexPath).section {
        case 0:
            return TaskDetailCell.cell(tableView: tableView)
        default:
            return TaskStepDetailCell.cell(tableView: tableView)
        }
    }
}
