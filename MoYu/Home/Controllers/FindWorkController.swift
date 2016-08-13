//
//  FindWorkController.swift
//  MoYu
//
//  Created by Chris on 16/4/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class FindWorkController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.mo_background()
        
        self.setupView()
        self.startLocation()
        self.followMode()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        locationService.delegate = self
        mapView.viewWillAppear()
        mapView.delegate = self
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationService.delegate = nil
        mapView.viewWillDisappear()
        mapView.delegate = nil
        
    }
    
    //MARK: - public method
    func startLocation(){
        
        locationService.startUserLocationService()
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeNone
        mapView.showsUserLocation = true
    }
    
    func stopLocation(){
        
        locationService.stopUserLocationService()
        mapView.showsUserLocation = false
    }
    
    func followMode(){
        
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeFollow
        mapView.showsUserLocation = true
    }
    
    func followHeadingMode(){
        
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading
        mapView.showsUserLocation = true
    }
    
    //MARK: - private method
    private func setupView(){
        
        self.view.addSubview(mapView)
        mapView.snp_makeConstraints { (make) in
            make.edges.equalTo(mapView.superview!)
        }
    }
    

    //MARK: - var & let
    lazy private var mapView:BMKMapView = {
        let map = BMKMapView()
        map.minZoomLevel = 6
        map.maxZoomLevel = 20
        map.zoomLevel = 16
        
        map.logoPosition = BMKLogoPositionRightBottom
        return map
    }()
    
    lazy private var locationService:BMKLocationService = {
        let location = BMKLocationService()
        location.allowsBackgroundLocationUpdates = true
        return location
    }()
    
    var location = MoYuLocation()
}

//MARK: - BMKMapView Delegate
extension FindWorkController:BMKMapViewDelegate{
    
}

//MARK: - BMKLocationService Delegate
extension FindWorkController:BMKLocationServiceDelegate{

    /**
     *在地图View将要启动定位时，会调用此函数
     *@param mapView 地图View
     */
    func willStartLocatingUser() {
        //print("willStartLocatingUser");
    }
    
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        //print("heading is \(userLocation.heading)")
        mapView.updateLocationData(userLocation)
    }
    
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        //print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        mapView.updateLocationData(userLocation)
        
        location = MoYuLocation(latitude: userLocation.location.coordinate.latitude, longtitude: userLocation.location.coordinate.longitude)
    }
    
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        //print("didStopLocatingUser")
    }
    

}
