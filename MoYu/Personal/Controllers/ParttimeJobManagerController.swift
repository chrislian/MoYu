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
        
        navigationItem.leftBarButtonItems = leftBarButtonItems
        
        self.title = "兼职管理"
        
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
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - private method
    private func setupView(){
        
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
    
    private lazy var leftBarButtonItems:[UIBarButtonItem] = {
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil , action: nil)
        spaceItem.width = 1//-16
        let barButton = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .Done, target: self, action: #selector(MessageCenterController.backButton(tap:)))
        return [spaceItem, barButton]
    }()
}

extension ParttimeJobManagerController: UITableViewDelegate{

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = cell as? ParttimeJobCell else{ return }
        
        cell.update(item: buttonType.rawValue)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
       let vc = UIViewController()
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ParttimeJobManagerController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ParttimeJobCell.cell(tableView: tableView)
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
}

