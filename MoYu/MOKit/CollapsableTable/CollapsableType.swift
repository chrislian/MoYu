//
//  CollapsableType.swift
//  MoYu
//
//  Created by 连晓彬 on 16/8/23.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

protocol CollapsableHeaderType {
    
    func open(animated:Bool)
    func close(animated:Bool)
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
    
    func userTappedView<T: UITableViewHeaderFooterView>(_ view: T, atPoint:CGPoint) where T: CollapsableHeaderType
}


extension CollapsableSectionHeaderInteractionType where Self: UIViewController {
    
    func userTappedView<T : UITableViewHeaderFooterView>(_ headerView: T, atPoint location: CGPoint) where T : CollapsableHeaderType {
        
        guard let tappedSection = sectionForUserSelection(inTableView: self.collapsableTableView, atTouchLocation: location, inView: headerView) else{ return }
        
        var foundOpenUnchosenMenuSection = false
        var section = 0
        
        self.collapsableTableView.beginUpdates()
        
        for var model in collapsableData {
            if tappedSection == section {
                
                model.isVisible = !model.isVisible
                toggleCollapseTableView(atSection: section, dataType: model, inTableView: self.collapsableTableView, usingAnimation: foundOpenUnchosenMenuSection ? .bottom: .top, headerType: headerView)
                
            } else if model.isVisible {
                model.isVisible = !model.isVisible
                
                foundOpenUnchosenMenuSection = true
                let headerType = self.collapsableTableView.headerView(forSection: section) as? CollapsableHeaderType
                toggleCollapseTableView(atSection: section, dataType: model, inTableView: self.collapsableTableView, usingAnimation: (tappedSection > section) ? .top: .bottom, headerType: headerType)
            }
            section += 1
        }
        self.collapsableTableView.endUpdates()
    }
    
    fileprivate func toggleCollapseTableView<DataType: CollapsableDataType>(atSection section:Int,
                                                   dataType: DataType,
                                                   inTableView: UITableView,
                                                   usingAnimation: UITableViewRowAnimation,
                                                   headerType:CollapsableHeaderType?){
        
    let indexPaths = self.indexPaths(section, menuSection: dataType)
        if dataType.isVisible{
            headerType?.open(animated: true)
            inTableView.insertRows(at: indexPaths, with: usingAnimation)
        }else{
            headerType?.close(animated: true)
            inTableView.deleteRows(at: indexPaths, with: usingAnimation)
        }
    }
    
    fileprivate func sectionForUserSelection(inTableView tableView: UITableView, atTouchLocation location:CGPoint, inView view: UIView) -> Int? {
        
        for i in 0..<tableView.numberOfSections where view == tableView.headerView(forSection: i){
            return i
        }
        
        return nil
    }
    
    fileprivate func indexPaths<DataType: CollapsableDataType>(_ section: Int, menuSection: DataType) -> [IndexPath] {
        
        var collector = [IndexPath]()
        
        for i in 0..<menuSection.items.count{
            collector.append(IndexPath(row: i, section: section))
        }
        
        return collector
    }
}
