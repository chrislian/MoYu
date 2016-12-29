//
//  MessageCenterController.swift
//  MoYu
//
//  Created by Chris on 16/8/8.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MessageCenterController: UIViewController,PraseErrorType, AlertViewType {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        mo_navigationBar(title: "消息中心")
        
        mo_rootLeftBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateMessage()
    }
    
    
    //MARK: - event response
    
    //MARK: - private method
    fileprivate func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background
        tableView.backgroundColor = UIColor.mo_background
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    fileprivate func updateMessage(){
        
        Router.messageCenter.request { (status, json) in
            
            self.show(error: status)
            
            if let data = json, case .success = status{
                
                self.messageModel.prase(response: data)
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
    
    lazy var messageModel = MessageCenterModel()
}

extension MessageCenterController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let cell  = cell as? MessageCenterCell else{
            return
        }
        cell.update(item: messageModel.items[(indexPath as NSIndexPath).section] )
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background
        vc.title = "详情"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MessageCenterController: UITableViewDataSource{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return messageModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MessageCenterCell.cell(tableView: tableView)
        cell.accessoryType = .none
        return cell
    }
}
