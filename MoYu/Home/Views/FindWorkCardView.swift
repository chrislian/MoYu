//
//  FindWorkCardView.swift
//  MoYu
//
//  Created by lxb on 2016/11/29.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit
import Spring

class FindWorkCardView: SpringView {

    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - public methods
    func show(){
        if !isVisable{
            self.animation = "slideUp"
            self.curve = "easeIn"
            self.duration = 1
            self.animate()
        }
        isVisable = true
    }
    
    func dismiss(_ duration:TimeInterval = 0.7){
        
        if isVisable{
            self.animation = "fadeOut"
            self.curve = "easeIn"
            self.duration = CGFloat(duration)
            self.animate()
        }
        isVisable = false
    }
    //MARK: - private methods

    
    //MARK: - var & let
    private(set) var isVisable = true
    
    let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: MoScreenWidth, height: 140)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.register(UINib(nibName: String(describing: FindWorkCardCell.self), bundle: nil), forCellWithReuseIdentifier: FindWorkCardCell.identifier)
        return view
    }()
}
