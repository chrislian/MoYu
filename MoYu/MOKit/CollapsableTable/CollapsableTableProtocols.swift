//
//  CollapsableTableProtocols.swift
//  meiqu
//
//  Created by yzh on 16/2/19.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import UIKit

protocol CollapsableTableViewSectionHeaderProtocol {
    func open(animated: Bool);
    func close(animated: Bool);
    var sectionTitleLabel: UILabel { get set }
    var interactionDelegate: CollapsableTableViewSectionHeaderInteractionProtocol! { get set }
    var tag: Int { get set }
}

protocol CollapsableTableViewSectionHeaderInteractionProtocol:class {
    func userTappedView<T: UITableViewHeaderFooterView where T: CollapsableTableViewSectionHeaderProtocol>(view: T, atPoint:CGPoint)
}

protocol CollapsableTableViewSectionModelProtocol {
    var title: NSAttributedString { get set }
    var subTitle: NSAttributedString { get set }
    var isVisible: Bool { get set }
    var items: [String] { get set }
}
