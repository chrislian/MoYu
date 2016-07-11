//
//  HomeMenuController.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeMenuController: UIViewController {

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
        println("sender.tag = \(sender.tag)")
        
    }
    
    private func setupMenuView(){
        
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        menuView.tableView.rowHeight = 80.0
    }

    //MARK: - var & let
    @IBOutlet var menuView: HomeMenuView!
    let menuModel = HomeMenuItemModel(items: 15)
}

extension HomeMenuController:UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tmpCell = cell as? HomeMenuCell else{
            return
        }
       tmpCell.updateCellWithImage(menuModel.datas[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension HomeMenuController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuModel.rows
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Main.Cell.homeMenu) else{
            return HomeMenuCell(style: .Default, reuseIdentifier: SB.Main.Cell.homeMenu)
        }
        return cell
    }
}


