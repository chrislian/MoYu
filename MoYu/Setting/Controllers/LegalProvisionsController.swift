//
//  LegalProvisionsController.swift
//  MoYu
//
//  Created by Chris on 16/8/13.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class LegalProvisionsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mo_navigationBar(title: "法律条款")
        
        self.setupView()
    }

    
    // MARK: - private method
    private func setupView(){
        
        self.view.backgroundColor = UIColor.mo_background()
        
        self.tableView.separatorStyle = .SingleLine
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        self.tableView.backgroundColor = UIColor.mo_background()
    }
    
    
    //MARK: - let & var
    
    @IBOutlet weak var tableView: UITableView!
    
    private let datas = ["*****条款","*****条款","*****条款"]
    
}

extension LegalProvisionsController:UITableViewDelegate{

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = UIViewController()
        vc.title = datas[indexPath.row]
        vc.view.backgroundColor = UIColor.mo_background()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension LegalProvisionsController:UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "legalProvisionIndentifier"
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else{
              
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
                
        }
        
        return cell
    }
    
}

