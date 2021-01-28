//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by zgagaSur on 22/11/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

// using variadic parameters
extension UIView {
    
    func pinToEdges(of superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func addSubviews (_ views: UIView ...) {
        for view in views {
            
            addSubview(view)
            
        }
    }
}
