//
//  PublishWorkController.swift
//  MoYu
//
//  Created by Chris on 16/4/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class PublishWorkController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.startLocation()
        
        self.view.backgroundColor = UIColor.mo_background()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationService.delegate = self
        mapView.viewWillAppear()
        mapView.delegate = self
        self.followMode()
        
        publishSheetView.dismiss(0)
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
        
        self.view.addSubview(publishSheetView)
        publishSheetView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-28)
        }
        self.view.bringSubview(toFront: publishSheetView)
        //publish button closure
        publishSheetView.publishClosure = { type in
            switch type {
            case .partTime:
                let vc = PostParttimeJobController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .task:
                let vc = PostTaskController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func makeAnnotation(location:MoYuLocation) ->BMKPointAnnotation{

        let annotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        annotation.title = ""
        return annotation;
    }
    
    
    //MARK: - var & let
    lazy fileprivate var mapView:BMKMapView = {
        let map = BMKMapView()
        map.minZoomLevel = 6
        map.maxZoomLevel = 20
        map.zoomLevel = 16
        
        map.logoPosition = BMKLogoPositionLeftBottom
        
        let param = BMKLocationViewDisplayParam()
        param.isRotateAngleValid = true// 跟随态旋转角度是否生效
        param.isAccuracyCircleShow = false// 精度圈是否显示
        param.locationViewImgName = "social_currentLocation"// 定位图标名称
        param.locationViewOffsetX = 0//定位图标偏移量(经度)
        param.locationViewOffsetY = 0// 定位图标偏移量(纬度)
        map.updateLocationView(with: param)//调用此方法后自定义定位图层生效
        
        return map
    }()
    
    lazy fileprivate var locationService:BMKLocationService = {
        let location = BMKLocationService()
        location.allowsBackgroundLocationUpdates = true
        return location
    }()
    
    fileprivate let publishSheetView = PublishSheetView()
    
    private var publishWorkAnnotation:BMKPointAnnotation?

    private var locationFlag = false
    fileprivate var location = MoYuLocation(){
        willSet{
//            if locationFlag {
//                return
//            }
//            locationFlag = true
            if let annotation = self.publishWorkAnnotation {
                self.mapView.removeAnnotation(annotation)
            }
            self.publishWorkAnnotation = self.makeAnnotation(location: newValue)
            self.mapView.addAnnotation(self.publishWorkAnnotation)
            self.mapView.isSelectedAnnotationViewFront = true
        }
    }
}

//MARK: - BMKMapView Delegate
extension PublishWorkController:BMKMapViewDelegate{
    
    /**
     *根据anntation生成对应的View
     *@param mapView 地图View
     *@param annotation 指定的标注
     *@return 生成的标注View
     */
//    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
//        
//        let annotationViewID = "publishWorkAnnotation"
//        let annotationView = PublishWorkAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
//        annotationView?.canShowCallout = false
//        return annotationView
//    }
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        
        publishSheetView.show()
        
    }
    
    func mapView(_ mapView: BMKMapView!, didDeselect view: BMKAnnotationView!) {
        
//        publishSheetView.dismiss()
        
    }
    
    func mapView(_ mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        
//        publishSheetView.dismiss()
    }
}

//MARK: - BMKLocationService Delegate
extension PublishWorkController:BMKLocationServiceDelegate{
    
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
        //print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        userLocation.title = nil
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
