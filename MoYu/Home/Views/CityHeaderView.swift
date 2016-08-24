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

class CityHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(sectionTitleLabel)
        sectionTitleLabel.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - event response
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesEnded(touches, withEvent: event)
        
        guard let touch = touches.first else {
            return
        }
        let point = touch.locationInView(self)
        self.interactionClourse?(atPoint:point)
    }
    
    //MARK: - var & let
    weak var delegate: CitySectionHeaderViewDelegate?
    
    var interactionClourse:((atPoint: CGPoint)-> Void)?

    var sectionIndex: Int = 0
    lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mo_lightBlack()
        label.font = UIFont.mo_font()
        return label
    }()
}

// MARK: - CollapsableHeaderType
extension CityHeaderView: CollapsableHeaderType{
    
    func open(animated animated: Bool) {
        self.delegate?.sectionHeaderView(sectionIndex, open: true)
    }
    
    func close(animated animated: Bool) {
        self.delegate?.sectionHeaderView(sectionIndex, open: false)
    }
}
