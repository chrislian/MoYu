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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationService.delegate = self
        mapView.viewWillAppear()
        mapView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addAnnotations()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
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
    fileprivate func setupView(){
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(mapView.superview!)
        }
    }
    
    private func addAnnotations(){
        
        mapView.addAnnotation(self.annotation1)
        
        mapView.addAnnotation(self.annotation2)
        
    }
    

    //MARK: - var & let
    lazy fileprivate var mapView:BMKMapView = {
        let map = BMKMapView()
        map.minZoomLevel = 6
        map.maxZoomLevel = 20
        map.zoomLevel = 16
        
        map.logoPosition = BMKLogoPositionRightBottom
        return map
    }()
    
    lazy fileprivate var locationService:BMKLocationService = {
        let location = BMKLocationService()
        location.allowsBackgroundLocationUpdates = true
        return location
    }()
    
    
    lazy var annotation1:BMKPointAnnotation = {
        
        let annotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(24.494, 118.19)
//        annotation.title = "自定义标题"
        return annotation
    }()
    lazy var annotation2:BMKPointAnnotation = {
        
        let annotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(24.490, 118.193)
        //        annotation.title = "自定义标题"
        return annotation
    }()
    
    var location = MoYuLocation()
}

//MARK: - BMKMapView Delegate
extension FindWorkController:BMKMapViewDelegate{
    
    /**
     *根据anntation生成对应的View
     *@param mapView 地图View
     *@param annotation 指定的标注
     *@return 生成的标注View
     */
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        if annotation === self.annotation1{
            let annotationViewID = "findWorkAnnotation"
            let annotationView = FindWorkAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            annotationView?.tag = 1
            return annotationView
        }else if annotation === self.annotation2{
            let annotationViewID = "findWorkAnnotation2"
            let annotationView = FindWorkAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            annotationView?.tag = 2
            return annotationView
        }
        return nil

    }
    
    /**
     *当选中一个annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 选中的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        println("选中了标注 tag = \(view.tag)")
    }

    /**
     *当取消选中一个annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 取消选中的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didDeselect view: BMKAnnotationView!) {
        println("取消选中标注 tag = \(view.tag)")
    }
    
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
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        //print("heading is \(userLocation.heading)")
        mapView.updateLocationData(userLocation)
    }
    
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!) {
//        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        //lat:24.4914423140249 lon:118.181261416303
        mapView.updateLocationData(userLocation)
        
        location = MoYuLocation(latitude: userLocation.location.coordinate.latitude, longitude: userLocation.location.coordinate.longitude)
    }
    
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        //print("didStopLocatingUser")
    }
    

}
