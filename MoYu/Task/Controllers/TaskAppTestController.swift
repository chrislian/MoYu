//
//  TaskAppTestController.swift
//  MoYu
//
//  Created by Chris on 16/9/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

final class TaskAppTestController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        mo_navigationBar(title: "任务详情")
    }
    
    //MARK: - event response
    @IBAction func taskButtonTap(_ sender: AnyObject) {
        
    }
    
    //MARK: - private methods
    fileprivate func setupView(){
        
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
