//
//  HotSearchView.swift
//  MoYu
//
//  Created by Chris on 16/8/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HotSearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.white
        setupView()
    }
    
     // MARK: - private method
    
    func setupView(){
    
        let label = UILabel(frame:CGRect(x: 10, y: 0, width: MoScreenWidth-10, height: 40))
        label.font = UIFont.mo_font()
        label.textColor = UIColor.mo_lightBlack
        label.text = "热门搜索"
        self.addSubview(label)
        
        self.addSubview(collectionView)
        
    }
    

    // MARK: - var & let
    
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect(x: 40, y: 40, width: MoScreenWidth-80, height: 160), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HotSearchMenuCell.self , forCellWithReuseIdentifier: "hotSearchCellIndentifier")
        return collectionView
    }()
    
}
