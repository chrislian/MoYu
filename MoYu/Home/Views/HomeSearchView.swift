//
//  HomeSearchView.swift
//  MoYu
//
//  Created by Chris on 16/4/10.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class HomeSearchView: UIView {

   
    override func awakeFromNib() {
        
        setupView()
    }
    
    //MARK: - private method
    private func setupView(){
        
        searchBar.backgroundImage = UIImage()
    }
    
    //MARK: - var & let
    @IBOutlet weak var searchBar: UISearchBar!
}
