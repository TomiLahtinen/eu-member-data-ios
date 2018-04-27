//
//  Flags.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 23/02/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation
import UIKit

class Flag {
    
    private static let SUFFIX = ".pdf"
    private static let EU_FLAG = UIImage(named:"EU Flag")!
    
    static func of(_ countryCode: String) -> UIImage {
        return UIImage(named: countryCode + Flag.SUFFIX) ?? Flag.EU_FLAG
    }
}
