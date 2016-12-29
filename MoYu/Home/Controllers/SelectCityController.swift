//
//  SelectCityController.swift
//  MoYu
//
//  Created by Chris on 16/8/16.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class CityModel:CollapsableDataType {
    
    var isVisible: Bool = false
    var provinceName: String
    var items: [String]
    
    
    init(input:(state:String, cities:[String])){
        provinceName = input.state
        items = input.cities
        items.removeFirst()
    }
}

class SelectCityController: UIViewController ,CollapsableSectionHeaderInteractionType{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择城市"
        setupTableView()
        loadLocationData()
    }

    //MARK: - private method
   fileprivate func setupTableView(){
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = UIColor.mo_background
//    tableView.separatorStyle = .None
    
    let headView = UIView(frame:CGRect(x: 0,y: 0,width: MoScreenWidth,height: 80))
    headView.addSubview(locationHeadView)
    tableView.tableHeaderView = headView;
    }

    fileprivate func loadLocationData(){
        
        SNLocationManager.share().startUpdatingLocation(success: { (location, placemark) in
            if let city = placemark?.locality {
                self.locationHeadView.locationLab.text = "当前位置：" + city
            }else{
                self.locationHeadView.locationLab.text = "当前位置：定位失败"
            }
            
        }, andFailure: { (region, error) in
                self.locationHeadView.locationLab.text = "当前位置：定位失败"
        })
    }
    
    //MARK: - var & let
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var locationHeadView = LocationHeadView(frame:CGRect(x: 0,y: 0,width: MoScreenWidth,height: 80))
    
    /// 综合两份列表。。。取出城市列表，各自的列表都不是很友好
    fileprivate var items: [CityModel] = {
        guard let path1 = Bundle.main.path(forResource: "city", ofType: "plist"),
            let stateArray = NSArray(contentsOfFile: path1) as? [[String:AnyObject]] else{
                return []
        }
        let states = stateArray.flatMap{ $0["state"] as? String }
        
        guard let path2 = Bundle.main.path(forResource: "cityData", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path2) as? [String: [String]]else{
            return []
        }
        
        return states.flatMap{ state -> CityModel? in
            guard let cities = dictionary[state] else{
                return nil
            }
            return CityModel(input: (state:state, cities:cities) )
        }
    }()
    
    
    var changeCityClourse: ( (String)->Void )?
    
    
    // MARK: - Collapsable
    var collapsableTableView: UITableView {
        return self.tableView
    }

    var collapsableData: [CityModel] {
        return self.items
    }
}

//MARK: - table view delegate
extension SelectCityController :UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: MoScreenWidth, height: 1)
        line.backgroundColor = UIColor.mo_background
        return line
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerType = view as? CollapsableHeaderType else {
            return
        }
        
        if (items[section].isVisible ) {
            headerType.open(animated: false)
        } else {
            headerType.close(animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.textLabel?.text = self.items[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.mo_mercury
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let city = self.items[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        let alert = UIAlertController(title: "提示", message: "是否切换到 \(city)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { [unowned self] _ in
            self.changeCityClourse?(city)
            let _ = self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - 选择区回调
extension SelectCityController: CitySectionHeaderViewDelegate{
    func sectionHeaderView(_ section:Int, open: Bool){
        //println("section = \(section), open :\(open)")
    }
}


//MARK: - table view data source
extension SelectCityController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuSection = items[section]
        
        return (menuSection.isVisible ) ? menuSection.items.count : 0
    }
    
    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CityHeaderView") as? CityHeaderView
        
        if header == nil{
            header = CityHeaderView(reuseIdentifier: "CityHeaderView")
        }
        
        header?.sectionIndex = section
        header?.interactionClourse = { [weak self] (point) in
            self?.userTappedView(header!, atPoint: point)
        }
        header?.delegate = self
        
        header?.sectionTitleLabel.text = items[section].provinceName
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "selectCityIndentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else{
            
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        return cell
    }
}
