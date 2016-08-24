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
    
    init(input:(name:String, citys:[String])) {
        provinceName = input.name
        items = input.citys.filter{ $0 != "不限" }
    }
}

class SelectCityController: BaseController ,CollapsableSectionHeaderInteractionType{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择城市"
        setupTableView()
        loadLocationData()
    }

    //MARK: - private method
   private func setupTableView(){
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = UIColor.mo_background()
//    tableView.separatorStyle = .None
    
    let headView = UIView(frame:CGRectMake(0,0,MoScreenWidth,80))
    headView.addSubview(locationHeadView)
    tableView.tableHeaderView = headView;
    }

    private func loadLocationData(){
        
        SNLocationManager.shareLocationManager().startUpdatingLocationWithSuccess({ (location, placemark) in
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
    var locationHeadView = LocationHeadView(frame:CGRectMake(0,0,MoScreenWidth,80))
    
    // MARK: - Collapsable
    private var items: [CityModel] =  {
        
        guard let path = NSBundle.mainBundle().pathForResource("cityData", ofType: "plist"),
            let dic = NSDictionary(contentsOfFile: path) as? [String: [String]] else{
                return  []
        }
        return dic.map( CityModel.init )//.sort { $0.provinceName > $1.provinceName }
    }()
    
    var collapsableTableView: UITableView {
        return self.tableView
    }

    var collapsableData: [CityModel] {
        return self.items
    }
}

//MARK: - table view delegate
extension SelectCityController :UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: MoScreenWidth, height: 1)
        line.backgroundColor = UIColor.mo_background()
        return line
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerType = view as? CollapsableHeaderType else {
            return
        }
        
        if (items[section].isVisible ?? false) {
            headerType.open(animated: false)
        } else {
            headerType.close(animated: false)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.textLabel?.text = self.items[indexPath.section].items[indexPath.row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.mo_mercury()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("select indexPath: \(indexPath)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
// MARK: - 选择区回调
extension SelectCityController: CitySectionHeaderViewDelegate{
    func sectionHeaderView(section:Int, open: Bool){
        //println("section = \(section), open :\(open)")
    }
}


//MARK: - table view data source
extension SelectCityController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuSection = items[section]
        
        return (menuSection.isVisible ?? false) ? menuSection.items.count : 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("CityHeaderView") as? CityHeaderView
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "selectCityIndentifier"
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else{
            
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        return cell
    }
}
