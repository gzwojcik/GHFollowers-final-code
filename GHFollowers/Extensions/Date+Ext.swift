//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by zgagaSur on 17/10/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}

