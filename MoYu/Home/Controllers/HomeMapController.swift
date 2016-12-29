//
//  HomeMapController.swift
//  MoYu
//
//  Created by lxb on 2016/12/7.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeMapController: UIViewController {
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.mo_background
        
        self.setupView()
        self.startLocation()
        self.followMode()
        
        zoomInTimer = Timer.cl_startTimer(interval: 0.1, repeats: true){ [unowned self] in
            if self.mapView.zoomLevel <= 16.0{
                self.mapView.zoomIn()
            }else{
                self.zoomInTimer?.invalidate()
                self.zoomInTimer = nil
            }
        }
        RunLoop.current.add(zoomInTimer!, forMode: .commonModes)
        
        NotificationCenter.add(observer: self, selector: #selector(onReceive(notify:)), name: MoNotification.updateUserInfo)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - public method
    func mapViewWillAppear(){
        mapView.viewWillAppear()
        
        locationService.delegate = self
        mapView.delegate = self
        geocodeSearch.delegate = self

    }
    
    func mapViewWillDisappear(){
        mapView.viewWillDisappear()
        
        locationService.delegate = nil
        mapView.delegate = nil
        geocodeSearch.delegate = nil
    }
    
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
    //MARK: - event response
    @objc private func onReceive(notify:NSNotification){
        if notify.name == MoNotification.updateUserInfo{
            self.updateFindWorks(currentLocation)
        }
    }
    
    
    //MARK: - private methods
    private func setupView(){
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(mapView.superview!)
        }
        
        mapView.addSubview(findWorkLeftView)
        findWorkLeftView.snp.makeConstraints { (make) in
            make.right.equalTo(mapView).offset(-8)
            make.centerY.equalTo(mapView).offset(-80)
            make.size.equalTo(CGSize(width:60,height:180))
        }
        
        mapView.addSubview(findWorkCardView)
        findWorkCardView.snp.makeConstraints { (make) in
            make.bottom.equalTo(mapView).offset(-28)
            make.left.right.equalTo(mapView)
            make.height.equalTo(140)
        }
        findWorkCardView.collectionView.delegate = self
        findWorkCardView.collectionView.dataSource = self
        
        
        mapView.addSubview(publishSheetView)
        publishSheetView.snp.makeConstraints { (make) in
            make.left.equalTo(mapView).offset(10)
            make.right.equalTo(mapView).offset(-10)
            make.bottom.equalTo(mapView).offset(-28)
        }
        publishSheetView.publishClosure = {[unowned self] type in
            switch type {
            case .partTime:
                let vc = PostParttimeJobController()
                vc.location = self.publishLocation
                self.publishClourse?(vc)
                //self.navigationController?.pushViewController(vc, animated: true)
                
            case .task:
                let vc = PostTaskController()
                vc.location = self.publishLocation
                self.publishClourse?(vc)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        findWorkCardView.dismiss(0)
        publishSheetView.dismiss(0)
        
        findWorkLeftView.show()
    }
    private func updateFindWorks(_ location:MoYuLocation){
        
        var currentPage = 1
        var allDatas = [FindWorkAnnoation]()
        
        func loadAllPartTimeJob(page:Int, clourse:@escaping (([FindWorkAnnoation])->Void)){
            
            Router.allPartTimeJobList(page: page, location: location).request { (status, json) in
                var datas:[FindWorkAnnoation] = []
                if case .success = status, let data = json?["reslist"].array{
                    datas = data.map( HomeMenuModel.init ).map( FindWorkAnnoation.init )
                }
                clourse(datas)
            }
        }
        
        func handlePartTimeJobs(datas:[FindWorkAnnoation]){
            
            allDatas.append(contentsOf: datas)
            if datas.count < 10{
                
                self.findWorkAnnotations = allDatas
            }else{
                currentPage += 1
                loadAllPartTimeJob(page: currentPage, clourse: handlePartTimeJobs)
            }
        }
        
        
        loadAllPartTimeJob(page: currentPage, clourse: handlePartTimeJobs)
    }
    
    private func changeMapModel(type:FindPublishWork){
        
        switch type {
        case .findWork:
            findWorkLeftView.show()
            publishSheetView.dismiss()
            
            if findWorkAnnotations.count > 0 {
                mapView.addAnnotations(findWorkAnnotations)
            }
            if let annotation = publishWorkAnnotation{
                mapView.removeAnnotation(annotation)
            }
            updateFindWorks(currentLocation)
        case .publishWork:
            
            findWorkLeftView.dismiss()
            findWorkCardView.dismiss()
            
            publishSheetView.show()
            publishLocation = currentLocation
            
            if findWorkAnnotations.count > 0 {
                mapView.removeAnnotations(findWorkAnnotations)
            }
            if let annotation = publishWorkAnnotation{
                mapView.addAnnotation(annotation)
            }
            currentAnnotationView = nil
            isFindWorkSelectItem = false
        }
    }
    
    private func makeAnnotation(location:MoYuLocation) ->BMKPointAnnotation{
        
        let annotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        annotation.title = ""
        return annotation;
    }
    
    fileprivate func reverseGeoLocation(location:MoYuLocation){
        
        let reverseGeoCodeSearchOption = BMKReverseGeoCodeOption()
        reverseGeoCodeSearchOption.reverseGeoPoint = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        if !geocodeSearch.reverseGeoCode(reverseGeoCodeSearchOption){
            println("反 geo检索发送失败")
        }
    }
    
    //MARK: - var & let
    var mapType:FindPublishWork = .findWork{
        didSet{
            if mapType != oldValue{
                changeMapModel(type: mapType)
            }
        }
    }
    
    lazy fileprivate var mapView:BMKMapView = {
        let map = BMKMapView()
        map.minZoomLevel = 6
        map.maxZoomLevel = 20
        map.zoomLevel = 11
        map.logoPosition = BMKLogoPositionLeftBottom
        map.isSelectedAnnotationViewFront = true
        
        
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
    
    fileprivate var findWorkDataArray:[FindWorkAnnoation] = []{
        didSet{
            findWorkCardView.collectionView.reloadData()
        }
    }
    
    fileprivate var findWorkAnnotations:[FindWorkAnnoation] = []{
        willSet{
            if findWorkAnnotations.count > 0 {
                mapView.removeAnnotations(findWorkAnnotations)
            }
        }
        didSet{
            if findWorkAnnotations.count > 0{
                mapView.addAnnotations(findWorkAnnotations)
            }
        }
    }
    
    
    fileprivate let findWorkCardView = FindWorkCardView()
    
    fileprivate var isFindWorkSelectItem = false
    
    fileprivate var currentAnnotationView:FindWorkAnnotationView?
    
    fileprivate let publishSheetView = PublishSheetView()
    
    fileprivate var publishWorkAnnotation:BMKPointAnnotation?
    
    lazy fileprivate var geocodeSearch: BMKGeoCodeSearch = {
        let search = BMKGeoCodeSearch()
        return search;
    }()
    
    
    let findWorkLeftView = HomeItemView()
    
    var publishLocation = MoYuLocation(){
        didSet{
            if publishLocation.latitude != oldValue.latitude || publishLocation.longitude != oldValue.longitude{
                self.reverseGeoLocation(location: publishLocation)
                
                if let annotation = self.publishWorkAnnotation {
                    self.mapView.removeAnnotation(annotation)
                }
                self.publishWorkAnnotation = self.makeAnnotation(location: publishLocation)
                if mapType == .publishWork {
                    self.mapView.addAnnotation(self.publishWorkAnnotation)
                }
            }
        }
    }
    
    var currentLocation = MoYuLocation(){
        didSet{
            if currentLocation.latitude != oldValue.latitude || currentLocation.longitude != oldValue.longitude{
                self.updateFindWorks(currentLocation)
            }
        }
    }
    
    var zoomInTimer:Timer?
    
    var publishClourse:((UIViewController)->Void)?
    var findWorkClourse:((HomeMenuModel)->Void)?

}

//MARK: - BMKMapView Delegate
extension HomeMapController:BMKMapViewDelegate{
    
    private func dismissFindWorkCardView(){
        isFindWorkSelectItem = false
        
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when){
            if !self.isFindWorkSelectItem{
                self.findWorkCardView.dismiss()
            }
        }
    }
    
    private func showFindWorkCardView(){
        
        isFindWorkSelectItem = true
        findWorkCardView.show()
    }
    
    private func deselectCurrentAnnotationView(){
        if let view = currentAnnotationView{
            mapView.deselectAnnotation(view.annotation, animated: true)
        }
    }
    
    
    /**
     *根据anntation生成对应的View
     *@param mapView 地图View
     *@param annotation 指定的标注
     *@return 生成的标注View
     */
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        switch mapType {
        case .findWork:
            let annotationViewID = "findWorkAnnotation"
            let annotationView = FindWorkAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            annotationView?.canShowCallout = false
            return annotationView
        case .publishWork:
            let annotationViewID = "publishWorkAnnotation"
            let annotationView = PublishWorkAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            annotationView?.isDraggable = true
            annotationView?.canShowCallout = false
            return annotationView
        }
        
    }
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        
        switch mapType {
        case .findWork:
            if let view = view as? FindWorkAnnotationView {
                view.updateSelect(status: true)
                currentAnnotationView = view
                showFindWorkCardView()
            }
            
            if let anotation = view.annotation as? FindWorkAnnoation{
                findWorkDataArray = [anotation]
            }
        case .publishWork:
            if let _ = view as? PublishWorkAnnotationView{
                publishSheetView.show()
            }
        }
    }
    
    func mapView(_ mapView: BMKMapView!, didDeselect view: BMKAnnotationView!) {
        
        switch mapType {
        case .findWork:
            if let view = view as? FindWorkAnnotationView {
                view.updateSelect(status: false)
                currentAnnotationView = nil
                dismissFindWorkCardView()
            }

        case .publishWork:
            if let _ = view as? PublishWorkAnnotationView{
                publishSheetView.dismiss()
            }
        }
    }
    
    func mapView(_ mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        
        switch mapType {
        case .findWork:
            deselectCurrentAnnotationView()
        case .publishWork:
            if let _ = view as? PublishWorkAnnotationView{
                publishSheetView.dismiss()
            }
        }
    }
    
    func mapView(_ mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        
        switch mapType {
        case .findWork:
            break
        case .publishWork:
            if publishSheetView.isVisable{
                publishSheetView.dismiss()
            }else{
                publishLocation = MoYuLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            }
        }
    }
}

//MARK: - BMKLocationService Delegate
extension HomeMapController:BMKLocationServiceDelegate{
    
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
        userLocation.title = nil
        mapView.updateLocationData(userLocation)
        
        let location = MoYuLocation(latitude: userLocation.location.coordinate.latitude, longitude: userLocation.location.coordinate.longitude)
        
        if publishLocation.latitude == 0 || publishLocation.longitude == 0 {
            publishLocation = location
        }
        
        if location.latitude != currentLocation.latitude || location.longitude != currentLocation.longitude {
            currentLocation = location
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeMapController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        findWorkClourse?(findWorkDataArray[indexPath.row].model)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeMapController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return findWorkDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindWorkCardCell.identifier, for: indexPath)
        if let cell = cell as? FindWorkCardCell{
            
            cell.update(annotation: findWorkDataArray[indexPath.row],myLocation: currentLocation)
        }
        return cell
    }
}


// MARK: - BMKGeoCodeSearchDelegate
extension HomeMapController: BMKGeoCodeSearchDelegate{
    
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
        if error == BMK_SEARCH_NO_ERROR {
            self.publishSheetView.locationLabel.text = result.address ?? "未知位置"
        }else{
            println("error:\(error)");
        }
    }
}
