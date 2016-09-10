//
//  RefreshViewType.swift
//  MoYu
//
//  Created by Chris on 16/8/13.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

protocol RefreshViewType {
    
    var refreshScrollView: UIScrollView { set get }
    
    func refreshAction()
}

extension RefreshViewType where Self: UIViewController{
    
    func beginRefresh(){
        
        guard let headerView = refreshScrollView.mj_header as? RefreshView where !headerView.isRefreshing() else{
            return
        }
        
        headerView.beginRefreshing()
    }
    
    func endRefresh(){
        guard let headerView = refreshScrollView.mj_header as? RefreshView where headerView.isRefreshing() else{
            return
        }
        
        headerView.endRefreshing()
    }
    
    func addRefreshView(){
        
        refreshScrollView.mj_header = RefreshView.refresh{ [unowned self] in
            self.refreshAction()
        }
    }
    
    func addRefreshView(clourse:Void->Void){
        
        refreshScrollView.mj_header = RefreshView.refresh( clourse )
        
        self.beginRefresh()
    }
}

private class RefreshView: RefreshHeaderView {
    
    class func refresh(block:()->Void )->RefreshView {
        let refreshView = RefreshView()
        refreshView.refreshingBlock = block
        return refreshView
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
    }
    override func isRefreshing() -> Bool {
        return super.isRefreshing()
    }
}
