//
//  MOFindWorkViewController.swift
//  MoYu
//
//  Created by Chris on 16/4/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class MOFindWorkViewController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor ( red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0 )
        
        self.setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.viewWillAppear()
        mapView.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        mapView.viewWillDisappear()
        mapView.delegate = nil
    }
    

    //MARK: - private method
    func setupView(){
        
        self.view.addSubview(mapView)
        mapView.snp_makeConstraints { (make) in
            make.edges.equalTo(mapView.superview!)
        }
    }
    
    //MARK: - var & let
    lazy var mapView = BMKMapView()
}

//MARK: - BMKMapView Delegate
extension MOFindWorkViewController:BMKMapViewDelegate{
    
}
