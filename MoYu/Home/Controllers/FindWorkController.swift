//
//  FindWorkController.swift
//  MoYu
//
//  Created by Chris on 16/4/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Async

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
        findWorkCardView.dismiss(0)
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
        
        mapView.addSubview(findWorkCardView)
        findWorkCardView.snp.makeConstraints { (make) in
            make.bottom.equalTo(mapView).offset(-28)
            make.left.right.equalTo(mapView)
            make.height.equalTo(140)
        }
        findWorkCardView.collectionView.delegate = self
        findWorkCardView.collectionView.dataSource = self
    }
    
    private func updateWorks(_ location:MoYuLocation){
        
        Router.allPartTimeJobList(page: 1, location: location).request { [weak self] (status, json) in
            if case .success = status, let data = json?["reslist"].array{
                
                let array = data.map( HomeMenuModel.init )
                
                self?.annotations = array.flatMap{
                    
                    if let latitude = Double($0.latitude), let longitude = Double($0.longitude){
                        let annotation = BMKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                        annotation.title = ""
                        return annotation
                    }
                    return nil
                }
                
                self?.dataArray = array
                self?.findWorkCardView.collectionView.reloadData()
            }
        }
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
    
    var updateWorksFlag = true
    var location = MoYuLocation(){
        willSet{
            if updateWorksFlag{
                updateWorksFlag = false
                self.updateWorks(newValue)
            }
        }
    }
    
    var dataArray:[HomeMenuModel] = []
    
    var annotations:[BMKPointAnnotation] = []{
        willSet{
            for annotation in annotations{
                mapView.removeAnnotation(annotation)
            }
        }
        didSet{
            for annotation in annotations{
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    lazy var findWorkCardView:FindWorkCardView = FindWorkCardView()
    
    var isSelectItem = false
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
        
        let annotationViewID = "findWorkAnnotation"
        let annotationView = FindWorkAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
        annotationView?.canShowCallout = false
        return annotationView
    }
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        
        if let view = view as? FindWorkAnnotationView {
            view.updateSelect(status: true)
        }
        
        isSelectItem = true
        findWorkCardView.show()
    }

    func mapView(_ mapView: BMKMapView!, didDeselect view: BMKAnnotationView!) {
        
        if let view = view as? FindWorkAnnotationView {
            view.updateSelect(status: false)
        }
        isSelectItem = false
        
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when){
            if !self.isSelectItem{
                self.findWorkCardView.dismiss()
            }
        }
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
        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
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

// MARK: - UICollectionViewDelegate
extension FindWorkController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension FindWorkController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindWorkCardCell.identifier, for: indexPath)
        if let cell = cell as? FindWorkCardCell{
        
            cell.update(model: dataArray[indexPath.row])
        }
        return cell
    }
}



