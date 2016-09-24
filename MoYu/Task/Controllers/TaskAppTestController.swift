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
        
        let title = self.taskModel?.name ?? "应用体验"
        mo_navigationBar(title: title)
    }
    
    //MARK: - event response
    @IBAction func taskButtonTap(sender: AnyObject) {
        
    }
    
    //MARK: - private methods
    private func setupView(){
        
        tableView.backgroundColor = UIColor.mo_background()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.registerNib(UINib(nibName: String(TaskDetailCell),bundle: nil), forCellReuseIdentifier: TaskDetailCell.identifier)
        tableView.registerClass(TaskStepDetailCell.self, forCellReuseIdentifier: TaskStepDetailCell.identifier)
    }
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskButton: UIButton!
    
    var taskModel :TaskModel?
}

// MARK: - UITableViewDelegate
extension TaskAppTestController: UITableViewDelegate{

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
            return headerLabel("步骤")
        }else if section == 2{
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
            cell.update(item: model)
        }else if let cell = cell as? TaskStepDetailCell, model = taskModel{
            if indexPath.section == 1{
                cell.update(model: model, isStep: true)
            }else{
                cell.update(model: model, isStep: false)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TaskAppTestController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
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
