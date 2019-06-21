//
//  Date.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/21/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

extension Date {
    
    func appStringFromDateBy(dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = dateFormat
        
        let stringDate = dateFormatter.string(from: self)
        
        if let date = dateFormatter.date(from: stringDate) {
            return dateFormatter.string(from: date)
        }
        return "--"
    }
}
