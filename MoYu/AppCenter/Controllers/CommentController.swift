//
//  CommentController.swift
//  MoYu
//
//  Created by lxb on 2016/12/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class CommentController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "评论"
        self.view.backgroundColor = UIColor.mo_background()
    
        setupView()
    }
    
    //MARK: - private methods
    private func setupView(){
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - var & let
    @IBOutlet weak var tableView: UITableView!
}

extension CommentController:UITableViewDelegate{

}

extension CommentController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            return CommentTopCell.cell(tableView: tableView)
        default:
            return UITableViewCell()
        }
    }
    
}
