//
//  AppCenterController.swift
//  MoYu
//
//  Created by Chris on 16/4/4.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class AppCenterController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mo_navigationBar(title: "应用中心")
        self.setupAppCenterView()
    }
    
    //MARK: - memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    //MARK: - private method
    fileprivate func setupAppCenterView(){
        tableView.backgroundColor = UIColor.mo_background
        bannerView.backgroundColor = UIColor.mo_background
        
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    //MARK: - var & let
    
    let cellTitles = [["职来职往"],["附近的人","积分购","任务大厅"]]
    let cellImages = [[UIImage(named:"rightAppCenterWork")!],
                      [UIImage(named:"rightAppCenterNear")!,
                      UIImage(named:"rightAppCenterCreidt")!,
                      UIImage(named:"rightAppCenterTask")!]]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: UIView!
}

extension AppCenterController:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            performSegue(withIdentifier: SB.AppCenter.Segue.aboutJobs, sender: self)
        case (1,0):
            performSegue(withIdentifier: SB.AppCenter.Segue.aroundPeople, sender: nil)
        case (1,2):
            guard let vc = SB.Task.root else{ return }
            present(vc, animated: true, completion: {[unowned self] in
                let _ = self.navigationController?.popViewController(animated: false)
            })
        default: break
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor  = UIColor.mo_background
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor  = UIColor.mo_background
        return view
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tmpCell = cell as? AppCenterCell else{
            println("cell error")
            return
        }
        tmpCell.updateCell(cellImages[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row], text: cellTitles[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row])
    }
}

extension AppCenterController:UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SB.AppCenter.Cell.appCenter){
            return cell
        }
        
        return LeftMenuCell(style: .default, reuseIdentifier: SB.AppCenter.Cell.appCenter)
    }
}
