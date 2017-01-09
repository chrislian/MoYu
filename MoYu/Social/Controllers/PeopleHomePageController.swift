//
//  PeopleHomePageController.swift
//  MoYu
//
//  Created by lxb on 2016/12/30.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

fileprivate enum PeopleHomePageCellType{
    
    case peopleAuth(peosonal:Bool,merchant:Bool)
   
    case jobIntension(job:String)
    
    case education(school:String)
    
    case jobScore
    
    var cellHeight:CGFloat{
        
        switch self {
        case .peopleAuth,.jobIntension,.education:
            return 60
        case .jobScore:
            return 201
        }
    }
    
}

class PeopleHomePageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        automaticallyAdjustsScrollViewInsets = false
        mo_navigationBar(title: aroundPeopleModel?.nickname ?? "", alpha: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
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
        
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = {
            $0.backgroundColor = UIColor.mo_background
            return $0
        }(UIView())
        
        if let model = aroundPeopleModel{
            
            homePageView.update(model: model)
        }
    }
    
    //MARK: - event response
    @IBAction func closeBarButton(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - var & let
    @IBOutlet var homePageView: HomePageView!
    
    fileprivate var tableView:UITableView{
        return homePageView.tableView
    }
    
    fileprivate let headerViewDefaultHeight:CGFloat = 345
    
    var aroundPeopleModel:AroundPeopleModel?
    
    fileprivate lazy var dataArray:[PeopleHomePageCellType] = {
        
        var data:[PeopleHomePageCellType] = []
        data.append(PeopleHomePageCellType.peopleAuth(peosonal: true, merchant: false))
        data.append(PeopleHomePageCellType.jobIntension(job: self.aroundPeopleModel?.intension ?? "无"))
        data.append(PeopleHomePageCellType.education(school: self.aroundPeopleModel?.school ?? "无"))
        data.append(PeopleHomePageCellType.jobScore)
        return data
    }()
}



// MARK: - UITableViewDelegate
extension PeopleHomePageController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.mo_background
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch dataArray[indexPath.row] {
        case .peopleAuth(let (peosonal, merchant)):
            if let cell = cell as? PeopleAuthCell{
                cell.update(personAuth: peosonal, merchantAuth: merchant)
            }
        case .jobIntension(let job):
            cell.textLabel?.text = "求职意向"
            cell.detailTextLabel?.text = job
        case .education(let school):
            cell.textLabel?.text = "毕业学校"
            cell.detailTextLabel?.text = school
        case .jobScore: break
        }
    }
}


// MARK: - UITableViewDataSource
extension PeopleHomePageController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func value1Cell()->UITableViewCell{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "personHomePageCellIdentifier") else{
                return UITableViewCell(style: .value1, reuseIdentifier: "personHomePageCellIdentifier")
            }
            return cell
        }
        
        switch dataArray[indexPath.row] {
        case .peopleAuth:
            return PeopleAuthCell.cell(tableView: tableView)
        case .jobIntension,.education:
            let cell = value1Cell()
            cell.textLabel?.font = UIFont.mo_font()
            cell.detailTextLabel?.font = UIFont.mo_font()
            cell.textLabel?.textColor = UIColor.mo_lightBlack
            cell.detailTextLabel?.textColor = UIColor.lightGray
            return cell
        case .jobScore: return JobScoreCell.cell(tableView: tableView)
        }
    }
}

//MARK: - UIScrollView
extension PeopleHomePageController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let color = UIColor.mo_main
        let navbarChangePoint:CGFloat = 217
        let offsetY = scrollView.contentOffset.y
        if offsetY > navbarChangePoint {
            let alpha = min(1, 1 - (navbarChangePoint + 64 - offsetY)/64)
            navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: color.withAlphaComponent(alpha))
            mo_navigationBar(title: aroundPeopleModel?.nickname ?? "", alpha:alpha)
        }else{
            navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: color.withAlphaComponent(0))
            mo_navigationBar(title: aroundPeopleModel?.nickname ?? "", alpha:0)
        }
    }
}
