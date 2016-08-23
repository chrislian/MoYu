//
//  CityHeaderView.swift
//  MoYu
//
//  Created by 连晓彬 on 16/8/23.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

protocol CitySectionHeaderViewDelegate: class{
    
    func sectionHeaderView(section:Int, open: Bool)
}

class CityHeaderView: UITableViewHeaderFooterView,CollapsableTableViewSectionHeaderProtocol {
    
    weak var delegate: CitySectionHeaderViewDelegate?
    
    var sectionIndex: Int = 0
    lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_main()
        label.font = UIFont.mo_font()
        return label
    }()
   
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
//        
//        // 修正autolayout布局报width或height为0
//        self.frame.size = CGSizeMake(CGFloat.max, 56)
        self.addSubview(sectionTitleLabel)
        sectionTitleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    weak var interactionDelegate: CollapsableTableViewSectionHeaderInteractionProtocol!
    
    func open(animated: Bool) {
        self.delegate?.sectionHeaderView(sectionIndex, open: true)
    }
    
    func close(animated: Bool) {
        self.delegate?.sectionHeaderView(sectionIndex, open: false)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesEnded(touches, withEvent: event)
        
        guard let touch = touches.first else {
            return
        }
        let point = touch.locationInView(self)
        interactionDelegate?.userTappedView(self, atPoint: point)
    }
}