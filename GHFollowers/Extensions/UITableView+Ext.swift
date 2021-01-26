//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by zgagaSur on 24/01/2021.
//  Copyright © 2021 Hime Electronics Int. All rights reserved.
//

import UIKit

extension UITableView { 
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}

