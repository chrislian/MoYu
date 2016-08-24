//
//  CollapsableType.swift
//  MoYu
//
//  Created by 连晓彬 on 16/8/23.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

protocol CollapsableHeaderType {
    
    func open(animated animated:Bool)
    func close(animated animated:Bool)
}

protocol CollapsableDataType {
    
    associatedtype ItemType
    
    var isVisible: Bool { get set }
    var items: [ItemType] { get set }
}


protocol CollapsableSectionHeaderInteractionType{
    
    associatedtype DataType:CollapsableDataType
    
    var collapsableTableView: UITableView { get }
    
    var collapsableData: [DataType] { get }
    
    func userTappedView<T: UITableViewHeaderFooterView where T: CollapsableHeaderType>(view: T, atPoint:CGPoint)
}


extension CollapsableSectionHeaderInteractionType where Self: UIViewController {
    
    func userTappedView<T : UITableViewHeaderFooterView where T : CollapsableHeaderType>(headerView: T, atPoint location: CGPoint) {
        
        guard let tappedSection = sectionForUserSelection(inTableView: self.collapsableTableView, atTouchLocation: location, inView: headerView) else{ return }
        
        var foundOpenUnchosenMenuSection = false
        var section = 0
        
        self.collapsableTableView.beginUpdates()
        
        for var model in collapsableData {
            if tappedSection == section {
                
                model.isVisible = !model.isVisible
                toggleCollapseTableView(atSection: section, dataType: model, inTableView: self.collapsableTableView, usingAnimation: foundOpenUnchosenMenuSection ? .Bottom: .Top, headerType: headerView)
                
            } else if model.isVisible {
                model.isVisible = !model.isVisible
                
                foundOpenUnchosenMenuSection = true
                let headerType = self.collapsableTableView.headerViewForSection(section) as? CollapsableHeaderType
                toggleCollapseTableView(atSection: section, dataType: model, inTableView: self.collapsableTableView, usingAnimation: (tappedSection > section) ? .Top: .Bottom, headerType: headerType)
            }
            section += 1
        }
        self.collapsableTableView.endUpdates()
    }
    
    private func toggleCollapseTableView<DataType: CollapsableDataType>(atSection section:Int,
                                                   dataType: DataType,
                                                   inTableView: UITableView,
                                                   usingAnimation: UITableViewRowAnimation,
                                                   headerType:CollapsableHeaderType?){
        
    let indexPaths = self.indexPaths(section, menuSection: dataType)
        if dataType.isVisible{
            headerType?.open(animated: true)
            inTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: usingAnimation)
        }else{
            headerType?.close(animated: true)
            inTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: usingAnimation)
        }
    }
    
    private func sectionForUserSelection(inTableView tableView: UITableView, atTouchLocation location:CGPoint, inView view: UIView) -> Int? {
        
        for i in 0..<tableView.numberOfSections where view == tableView.headerViewForSection(i){
            return i
        }
        
        return nil
    }
    
    private func indexPaths<DataType: CollapsableDataType>(section: Int, menuSection: DataType) -> [NSIndexPath] {
        
        var collector = [NSIndexPath]()
        
        for i in 0..<menuSection.items.count{
            collector.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        return collector
    }
}