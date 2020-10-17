//
//  String+Ext.swift
//  GHFollowers
//
//  Created by zgagaSur on 17/10/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

extension String {
    
    
    //NSDateFormatter.com
    
    func convertToDate() -> Date? {
        // optional it cant return nill
        
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        
        return dateFormatter.date(from: self)
    }
    
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
