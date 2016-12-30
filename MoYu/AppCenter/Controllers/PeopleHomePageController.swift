//
//  PeopleHomePageController.swift
//  MoYu
//
//  Created by lxb on 2016/12/30.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PeopleHomePageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: UIColor.clear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.lt_reset()
        navigationController?.navigationBar.isTranslucent = false
    }
    

    
    //MARK: - private mthods
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    //MARK: - var & let

    @IBOutlet weak var tableView: UITableView!
    
}



// MARK: - UITableViewDelegate
extension PeopleHomePageController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


// MARK: - UITableViewDataSource
extension PeopleHomePageController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//MARK: - UIScrollView
extension PeopleHomePageController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let color = UIColor.mo_main
        let navbarChangePoint:CGFloat = 217 - 64
        let offsetY = scrollView.contentOffset.y
        if offsetY > navbarChangePoint {
            let alpha = min(1, 1 - (navbarChangePoint + 64 - offsetY)/64)
            navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: color.withAlphaComponent(alpha))
        }else{
            navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: color.withAlphaComponent(0))
        }
    }
}
