//
//  ParttimeJobManagerController.swift
//  MoYu
//
//  Created by Chris on 16/8/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

enum ParttimeJobType: Int {
    case recurit = 1
    case announce
}


class ParttimeJobManagerController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: "兼职管理")
        
        mo_rootLeftBackButton()
        
        self.setupView()
        
//        Router.myParttimeJobList(page: 1).request { (status, json) in
//            print("status:\(status)")
//        }
//        Router.myTaskList(page: 1).request { (status, json) in
//            print("status:\(status)")
//        }
    }
    
    //MARK: - event response
    func backButton(tap sender:AnyObject){
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - private method
    fileprivate func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        parttimeJobView.backgroundColor = UIColor.mo_background()
        
        parttimeJobView.tableView.delegate = self
        parttimeJobView.tableView.dataSource = self
        parttimeJobView.tableView.rowHeight = 145
        parttimeJobView.tableView.sectionHeaderHeight = 8
        parttimeJobView.tableView.sectionFooterHeight = 0.01
        
        parttimeJobView.changeButtonType = { [weak self] type in
            self?.buttonType = type
            self?.parttimeJobView.tableView.reloadData()
        }
    }
    
    //MARK: - var & let
    @IBOutlet var parttimeJobView: ParttimeJobView!
    
    var buttonType = ParttimeJobType.recurit
}

extension ParttimeJobManagerController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? ParttimeJobCell else{ return }
        
        cell.update(item: buttonType.rawValue)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ParttimeJobManagerController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ParttimeJobCell.cell(tableView: tableView)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

