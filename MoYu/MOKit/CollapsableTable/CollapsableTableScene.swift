//
//  CollapsableTableScene.swift
//  meiqu
//
//  Created by yzh on 16/2/19.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//


import UIKit

class CollapsableTableViewController: BaseController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let tableView = collapsableTableView() else {
            return
        }
        
        guard let nibName = sectionHeaderNibName() else {
            return
        }
        
        guard let reuseID = sectionHeaderReuseIdentifier() else {
            return
        }
        
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseID)
    }
    
    /*!
    * @discussion Override this method to return a custom table view.
    * @return the table view. Is nil unless overriden.
    */
    func collapsableTableView() -> UITableView? {
        return nil
    }

    /*!
    * @discussion Override this method to return a custom model for the table view.
    * @return the model for the table view. Is nil unless overriden.
    */
    func model() -> [CityModel]? {
        return nil
    }
        
    /*!
    * @discussion Only one section is visible when the user taps to select a section. Deselecting an open section, closes all sections. By returning 'NO' for this value, then this rule is ignored.
    * @return a boolean indication for conforming to the single open selection rule. Is 'NO' by defualt.
    */
    func singleOpenSelectionOnly() -> Bool {
        return false
    }

    /*!
    * @discussion Override this method to return the nib name of your UITableViewHeaderFooterView subclass.
    * @return the section header nib name. Is nil unless overriden.
    */
    func sectionHeaderNibName() -> String? {
        return nil
    }

    func sectionHeaderReuseIdentifier() -> String? {
        return sectionHeaderNibName()?.stringByAppendingString("ID")
    }
    
}

extension CollapsableTableViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        guard let model = self.model() else {
            return 0
        }
        
        return model.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let model = self.model() else {
            return 0
        }
        
        let menuSection = model[section]
        
        return (menuSection.isVisible ?? false) ? menuSection.items.count : 0
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let reuseID = self.sectionHeaderReuseIdentifier() else {
            return nil
        }
        
        guard var view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(reuseID) as? CollapsableTableViewSectionHeaderProtocol else {
            return nil
        }
        
        guard let model = self.model() else {
            return nil
        }
        
        view.sectionTitleLabel.attributedText = model[section].title
        view.interactionDelegate = self
        
        return view as? UIView
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension CollapsableTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let view = view as? CollapsableTableViewSectionHeaderProtocol else {
            return
        }
        
        guard let model = self.model() else {
            return
        }
        
        if (model[section].isVisible ?? false) {
            view.open(false)
        } else {
            view.close(false)
        }
        if sectionAlwaysSelected(section){
           view.sectionTitleLabel.textColor = UIColor.mo_main()
        }
        
    }
}

extension CollapsableTableViewController: CollapsableTableViewSectionHeaderInteractionProtocol {
    
    func userTappedView<T : UITableViewHeaderFooterView where T : CollapsableTableViewSectionHeaderProtocol>(headerView: T, atPoint location: CGPoint) {
        
        guard let tableView = self.collapsableTableView() else {
            return;
        }
            
        guard let tappedSection = sectionForUserSelectionInTableView(tableView, atTouchLocation: location, inView: headerView) else {
            return
        }
        
        guard let collection = self.model() else {
            return
        }
        
        var foundOpenUnchosenMenuSection = false
        
        var section = 0
        
        tableView.beginUpdates()
        
        for var model in collection {
            
            if tappedSection == section {
                
                model.isVisible = !model.isVisible
                
                toggleCollapseTableViewSectionAtSection(section, withModel:model, inTableView: tableView, usingAnimation: (foundOpenUnchosenMenuSection) ? .Bottom : .Top, forSectionWithHeaderFooterView: headerView)
                
            } else if model.isVisible && self.singleOpenSelectionOnly() {
                
                foundOpenUnchosenMenuSection = true
                
                model.isVisible = !model.isVisible
                
                let untappedHeaderView = tableView.headerViewForSection(section) as? CollapsableTableViewSectionHeaderProtocol
                toggleCollapseTableViewSectionAtSection(section, withModel: model, inTableView: tableView, usingAnimation: (tappedSection > section) ? .Top : .Bottom, forSectionWithHeaderFooterView: untappedHeaderView)
            }
            
            section += 1
        }
        
        tableView.endUpdates()
        
    }
    
    private func toggleCollapseTableViewSectionAtSection(section: Int, withModel model: CityModel, inTableView tableView:UITableView, usingAnimation animation:UITableViewRowAnimation, forSectionWithHeaderFooterView headerFooterView: CollapsableTableViewSectionHeaderProtocol?) {
        
        let indexPaths = self.indexPaths(section, menuSection: model)
        
        if model.isVisible {
            headerFooterView?.open(true)
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
        } else {
            headerFooterView?.close(true)
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
        }
        if sectionAlwaysSelected(section){
             headerFooterView?.sectionTitleLabel.textColor = UIColor.mo_main()
//            if let view = headerFooterView as? MQCourseSectionHeaderView {
//                view.setSectionTitleColor(.RGB(MQUICOLOR_RED_DEFAULT))
//            }
//
        }
    }
    func sectionAlwaysSelected(section:Int)->Bool{
        return false
    }
    private func sectionForUserSelectionInTableView(tableView: UITableView, atTouchLocation location:CGPoint, inView view: UIView) -> Int? {
        
        for i in 0..<tableView.numberOfSections where view == tableView.headerViewForSection(i){
            return i
        }
        
        return nil
    }
    
    private func indexPaths(section: Int, menuSection: CityModel) -> [NSIndexPath] {
        
        var collector = [NSIndexPath]()

        for i in 0..<menuSection.items.count{
            collector.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        return collector
    }
}