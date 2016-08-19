//
//  SelectCityController.swift
//  MoYu
//
//  Created by Chris on 16/8/16.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class SelectCityController: BaseController {

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
    
    let headView = UIView(frame:CGRectMake(0,0,MoScreenWidth,60))
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
    var locationHeadView = LocationHeadView(frame:CGRectMake(0,16,MoScreenWidth,44))
    
    var cityPlist:[String: [String] ] = {
        
        guard let path = NSBundle.mainBundle().pathForResource("cityData", ofType: "plist"),
            let dic = NSDictionary(contentsOfFile: path) as? [String: [String]] else{
                return  [:]
        }
        return dic
    }()
}

//MARK: - table view delegate
extension SelectCityController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let keys = cityPlist.sort{ $0.0 < $1.0 }.map{ $0.0 }
        
        cell.textLabel?.text = keys[indexPath.row]
        cell.textLabel?.font = UIFont.mo_font()
        cell.textLabel?.textColor = UIColor.mo_lightBlack()
        
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame:CGRect(x: 20, y: 0, width: MoScreenWidth - 20, height: 30))
        label.backgroundColor = UIColor.groupTableViewBackgroundColor()
        label.font = UIFont.mo_font()
        label.textColor = UIColor.grayColor()
        label.text = "     手动选择"
        return label
    }

}


//MARK: - table view data source
extension SelectCityController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityPlist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "selectCityIndentifier"
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else{
            
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            
        }
        
        return cell
    }
}
