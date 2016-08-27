//
//  PostParttimeJobController.swift
//  MoYu
//
//  Created by Chris on 16/8/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PostParttimeJobController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "发布兼职"
        
        self.setupView()
    }

    //MARK: - event response
    dynamic private func nextButtonClicked(sender:UIButton){
        
        let vc = PostPartimeJobDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
        }
        
        self.view.addSubview(nextButton)
        nextButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-10)
            make.top.equalTo(tableView.snp_bottom).offset(10)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - var & let

    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .Grouped)
        tableView.rowHeight = 44.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.mo_background()
        return tableView
    }()
    
    private lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("下一步", forState: .Normal)
        button.setTitleColor(UIColor.mo_lightBlack(), forState: .Normal)
        button.titleLabel?.font = UIFont.mo_font(.bigger)
        button.backgroundColor = UIColor.mo_main()
        button.layer.borderColor = UIColor.mo_lightBlack().CGColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(PostParttimeJobController.nextButtonClicked(_:)), forControlEvents: .TouchUpInside)
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
        textfield.placeholder = "在此输入需要的人数"
        textfield.keyboardType = .NumberPad
        return 2
    })    
    
    private let dataArrays = [["种类","时间", "人数"], ["性别", "专业", "学历"], ["金额", "工时"]]
    
    lazy var catetoryTypeInfo = ["餐厅" ,"日薪" ,"模特" ,"派单" ,"服务员" ,"促销" ,"客服" ,"麦当劳"]
    
    lazy var sexTypeInfo = ["不限", "女", "男"]
    
    lazy var postModel = PostPartTimeJobModel()
}

//MARK: - UITableView delegate
extension PostParttimeJobController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.textLabel?.text = dataArrays[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        
        cell.detailTextLabel?.font = UIFont.mo_font()
        cell.detailTextLabel?.textColor = UIColor.mo_silver()
        
        var detailText = ""
        switch(indexPath.section,indexPath.row){
        case (0,0)://类型
            if postModel.type == 0{
                detailText = "请选择"
            }else{
                detailText = catetoryTypeInfo[postModel.type - 1]
            }
        case (0,2)://人数
            if postModel.sum == 0{
                detailText = "不限"
            }else{
                detailText = "\(postModel.sum)人"
            }
        case (1,0):
            detailText = sexTypeInfo[postModel.sex]
            
            
        default: break
        }
        cell.detailTextLabel?.text = detailText

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            categoryTypeAction.show(self)
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
        default:
            break
        }
    }
}

// MARK: - UITableView DataSource
extension PostParttimeJobController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArrays.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrays[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "postTimeJobIdentifier"
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellId) else{
            return UITableViewCell(style: .Value1, reuseIdentifier: cellId)
        }
        return cell

    }
}

extension PostParttimeJobController: ActionSheetProtocol{
    
    func otherButtons(sheet sheet:ActionSheetController)->[String]{
        
        if sheet == categoryTypeAction{
            return catetoryTypeInfo
        }else if sheet == sexTypeAction{
            return sexTypeInfo
        }
        
        return []
    }
    
    func action(sheet sheet: ActionSheetController, selectedAtIndex: Int){
        
        if sheet === categoryTypeAction{
            postModel.type = selectedAtIndex + 1
        }else if sheet === sexTypeAction{
            postModel.sex = selectedAtIndex
        }
        self.tableView.reloadData()
    }
}
