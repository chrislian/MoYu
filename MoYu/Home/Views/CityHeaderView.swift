//
//  CityHeaderView.swift
//  MoYu
//
//  Created by 连晓彬 on 16/8/23.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

protocol CitySectionHeaderViewDelegate: class{
    
    func sectionHeaderView(_ section:Int, open: Bool)
}

class CityHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        self.addSubview(sectionTitleLabel)
        sectionTitleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - event response
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        let point = touch.location(in: self)
        self.interactionClourse?(point)
    }
    
    //MARK: - var & let
    weak var delegate: CitySectionHeaderViewDelegate?
    
    var interactionClourse:((_ atPoint: CGPoint)-> Void)?

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
    
    func open(animated: Bool) {
        self.delegate?.sectionHeaderView(sectionIndex, open: true)
    }
    
    func close(animated: Bool) {
        self.delegate?.sectionHeaderView(sectionIndex, open: false)
    }
}
