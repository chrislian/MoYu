//
//  MessageController.swift
//  MoYu
//
//  Created by Chris on 16/4/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeMessageController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        setupMessageView()
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - private method
    fileprivate func setupMessageView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.mo_mercury
    }

    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
}


//MARK: - table view delegate
extension HomeMessageController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - table view data source
extension HomeMessageController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Main.Cell.homeMessage) else{
            return HomeMessageCell(style: .default, reuseIdentifier: SB.Main.Cell.homeMessage)
        }
        return cell
    }
}
