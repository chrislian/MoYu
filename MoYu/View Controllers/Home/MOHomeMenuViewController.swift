//
//  MOHomeMenuViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOHomeMenuViewController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        self.navigationController?.navigationBar.hidden = false
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }


    //MARK: - event reponse
    @IBAction func leftButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func rightButtonClicked(sender: UIButton) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func headViewButtonClicked(sender: UIButton) {
        MOLog("sender.tag = \(sender.tag)")
        
    }
    
    private func setupMenuView(){
        
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        menuView.tableView.rowHeight = 100.0
    }

    //MARK: - var & let
    @IBOutlet var menuView: MOHomeMenuView!
    let menuModel = MOHomeMenuItemModel(items: 15)
}

extension MOHomeMenuViewController:UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tmpCell = cell as? MOHomeMenuCell else{
            return
        }
       tmpCell.updateCellWithImage(menuModel.datas[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension MOHomeMenuViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuModel.rows
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Main.Cell.homeMenu) else{
            return MOHomeMenuCell(style: .Default, reuseIdentifier: SB.Main.Cell.homeMenu)
        }
        return cell
    }
}


