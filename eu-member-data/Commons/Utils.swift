//
//  Utils.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 26/04/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation

struct Utils {
    
    static var userLang: String {
        return Bundle.main.preferredLocalizations.first ?? "en" // Fallback to english
    }
    
    static var defaultDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
    
    static var isoDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
