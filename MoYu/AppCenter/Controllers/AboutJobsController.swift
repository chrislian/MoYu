//
//  AboutJobsController.swift
//  MoYu
//
//  Created by Chris on 16/4/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import SwiftyJSON

class AboutJobsController: UIViewController, PraseErrorType, AlertViewType, RefreshViewType {

    //MARK: -  life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "职来职往"
        
        self.setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceive(notify:)), name: NSNotification.Name(rawValue: UserNotification.updateAboutJob), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - event response
    func rightBarButtonClicked(_ sender:UIButton){
        self.performSegue(withIdentifier: SB.AppCenter.Segue.personMsg, sender: self)
    }
    
    func publishButtonClicked(_ sender:UIButton){
        self.performSegue(withIdentifier: SB.AppCenter.Segue.publishMsg, sender: self)
    }
    
    func refreshAction() {
        
        updateData(withPage: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CommentController, let model = sender as? AboutJobItem {
            vc.aboutJobModel = model
        }
    }
    
    func onReceive(notify:Notification){
        if notify.name.rawValue == UserNotification.updateAboutJob{
            beginRefresh()
        }
    }
    
    
    //MARK: - private method
    fileprivate func setupView(){
    
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(publishButton)
        publishButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.right.equalTo(publishButton.superview!).offset(-30)
            make.bottom.equalTo(publishButton.superview!).offset(-60)
        }
        
        self.addRefreshView()
        self.beginRefresh()
    }
    
    fileprivate func updateData(withPage page:Int){
        Router.jobZoneList(page: page).request { [weak self] (status, json) in
            
            self?.show(error: status)
            
            self?.updateJob(list: json)
            
            self?.endRefresh()
        }
    }
    
    fileprivate func updateJob(list json:JSON?){
        
        aboutJobModel = AboutJobModel(json: json)
        if aboutJobModel.items.count > 0{
            aboutJobModel.items.sort{ $0.create_time.compare($1.create_time) == .orderedDescending }
            tableView.reloadData()
        }
    }
    
    fileprivate func zanTap(withItem item:AboutJobItem){
        
//        if item.zan{
//            
//            self.showAlert(message: "已点过赞了~")
//            return
//        }
        
        Router.jobZoneZan(id: item.id, value: true).request { (status, json) in
            self.show(error: status, showSuccess: true)
            
            if case .success = status {
                self.updateData(withPage: 1)
            }
        }
    }
    
    fileprivate func commentTap(withItem item:AboutJobItem){
        
        self.performSegue(withIdentifier: SB.AppCenter.Segue.comments, sender: item)
    }
    
    
    //MARK: - var & let
    
    var aboutJobModel = AboutJobModel()
    
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshScrollView: UIScrollView = self.tableView
    
    lazy var rightBarButton:UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"icon_message")
        button.setBackgroundImage(image, for: UIControlState())
        button.setTitle("", for: UIControlState())
        button.tag = 1
        button.addTarget(self, action: #selector(rightBarButtonClicked(_:)), for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var publishButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: UIControlState())
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named:"icon_publish"), for: UIControlState())
        button.addTarget(self, action: #selector(publishButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
}

extension AboutJobsController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        
        guard let cell = cell as? AboutJobsCell else{
            return
        }
        cell.update(item: aboutJobModel.items[indexPath.section])
        
        cell.zanClourse = { [unowned self] jobZoneItem in
            
            guard let item = jobZoneItem else{
                return
            }
            self.zanTap(withItem: item)
        }
        
        cell.commentClourse = { [unowned self] jobZoneItem in
            guard let item = jobZoneItem else{ return }
            
            self.commentTap(withItem: item)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = aboutJobModel.items[indexPath.section]
        self.commentTap(withItem: item)
    }
}

extension AboutJobsController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return aboutJobModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return AboutJobsCell.cell(tableView: tableView)
    }
}
