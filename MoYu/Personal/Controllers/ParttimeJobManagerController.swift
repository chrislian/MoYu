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


class ParttimeJobManagerController: BaseController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackNavigationButton()
        
        self.title = "兼职管理"
        
        self.setupView()
    }
    
    //MARK: - event reponse
    
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

