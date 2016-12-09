//
//  GetParttimeJobDetailController.swift
//  MoYu
//
//  Created by lxb on 2016/12/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class GetParttimeJobDetailController: UIViewController,PraseErrorType,AlertViewType {
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mo_navigationBar(title: "兼职详情")
        setupView()
    }
    
    //MARK: - private methods
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        
        tableView.register(UINib(nibName:String(describing: TaskDetailCell.self),  bundle: nil), forCellReuseIdentifier: TaskDetailCell.identifier)
        
        grabButton.layer.cornerRadius = 2.0
        grabButton.layer.masksToBounds = true
        grabButton.layer.borderColor = UIColor.lightGray.cgColor
        grabButton.layer.borderWidth = 0.5
        
        grabButton.addTarget(self, action: #selector(grabButtonClicked(sender:)), for: .touchUpInside)
        
        updateGrabButton(status: jobModel?.status ?? 0)
        
    }
    
    private func updateGrabButton(status:Int){
        
        grabButton.tag = status
        if status == 0 {
            grabButton.backgroundColor = UIColor.mo_main()
            grabButton.setTitle("立即抢单", for: .normal)
            grabButton.setTitleColor(UIColor.mo_lightBlack(), for: .normal)
            grabButton.isEnabled = true
        }else if status == 1{
            grabButton.backgroundColor = UIColor.mo_main()
            grabButton.setTitle("确认完成", for: .normal)
            grabButton.setTitleColor(UIColor.mo_lightBlack(), for: .normal)
            grabButton.isEnabled = true
        }else if status == 2{
            grabButton.backgroundColor = UIColor.gray
            grabButton.setTitle("等待商家确认", for: .normal)
            grabButton.setTitleColor(UIColor.white, for: .normal)
            grabButton.isEnabled = false
        }
    }

    
    //MARK: - event response
    @objc private func grabButtonClicked(sender:UIButton){
        
        guard let model = jobModel else{ return }
        
        Router.getParttimeJob(order: model.order, status: 0).request {[weak self] (status, json) in
         
            self?.show(error: status, showSuccess: true)

            if case .success = status, let json = json{
                
                let model = HomeMenuModel(json: json)
                self?.jobModel = model
                self?.updateGrabButton(status: model.status)
            }
        }
    }
    
    //MARK: - var & let
    var jobModel:HomeMenuModel?
    lazy fileprivate var catetoryTypeInfo = ["餐厅" ,"日薪" ,"模特" ,"派单" ,"服务员" ,"促销" ,"客服" ,"麦当劳"]
    
    lazy fileprivate var sexTypeInfo = ["不限", "女", "男"]

    @IBOutlet weak var grabButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
}

extension GetParttimeJobDetailController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.01
        }else if section == 1{
            return 8
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 || section == 1{
            return 8
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 80
        }else if(indexPath.section == 2){
            return 50
        }else if(indexPath.section == 3){
            return 250
        }
        return 44
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}

extension GetParttimeJobDetailController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 6
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 2 {
            return "地址"
        }else if section == 3{
            return "内容"
        }
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func section1Cell(left:String, right:String)->UITableViewCell{
            let cellIdentifier = "getParttimeJobIdentifier"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            if cell == nil{
                cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
            }
            cell?.textLabel?.font = UIFont.mo_font()
            cell?.textLabel?.textColor = UIColor.mo_lightBlack()
            
            cell?.detailTextLabel?.font = UIFont.mo_font()
            cell?.detailTextLabel?.textColor = UIColor.mo_silver()
            
            cell?.textLabel?.text = left
            cell?.detailTextLabel?.text = right
            return cell!
        }
        
        if indexPath.section == 0 {
            let cell = TaskDetailCell.cell(tableView: tableView)
            if let model = jobModel{
                cell.update(item: model)
            }
            return cell
        }else if indexPath.section == 1 && indexPath.row == 0{
            var type = jobModel?.type ?? 0
            if type != 0{
                type -= 1
            }
            return section1Cell(left: "种类", right: self.catetoryTypeInfo[type])
        }else if indexPath.section == 1 && indexPath.row == 1{
            return section1Cell(left: "性别", right: self.sexTypeInfo[jobModel?.sex ?? 0])
        }else if indexPath.section == 1 && indexPath.row == 2{
            return section1Cell(left: "专业", right: jobModel?.profession ?? "不限")
        }else if indexPath.section == 1 && indexPath.row == 3{
            return section1Cell(left: "学历", right: jobModel?.education ?? "不限")
        }else if indexPath.section == 1 && indexPath.row == 4{
            return section1Cell(left: "时间", right: jobModel?.time.mo_ToString(.default) ?? "")
        }else if indexPath.section == 1 && indexPath.row == 5{
            return section1Cell(left: "工时", right: String(format:"%0.1f小时",jobModel?.workingtime ?? 0))
        }else if indexPath.section == 2{
            let cell = ParttimeJobContentCell.cell(tableView: tableView)
            cell.textView.text = jobModel?.address ?? ""
            return cell
        }else if(indexPath.section == 3){
            let cell = ParttimeJobContentCell.cell(tableView: tableView)
            cell.textView.text = jobModel?.content ?? ""
            return cell
        }
        
        return UITableViewCell()
    }
}
