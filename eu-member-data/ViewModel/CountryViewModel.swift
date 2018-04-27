//
//  CountryViewModel.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 26/04/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation

typealias CountryDataRow = (title: String, value: String, actionable: Bool)

enum Section: Int {
    case basic
    case capital
    case joined
    
    func caption() -> String {
        switch self {
        case .basic:
            return "Basic info"
        case .capital:
            return "Capital city"
        case .joined:
            return "Join dates"
        }
    }
    
    static var count: Int {
        return 3
    }
}

class CountryViewModel {
    
    let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var numberOfSections: Int {
        return 3
    }
        
    func data(in section: Section) -> [CountryDataRow] {
        switch section {
        case .basic:
            return basicData
        case .capital:
            return capitalData
        case .joined:
            return joinedData
        }
    }
    
    private var basicData: [CountryDataRow] {
        return [("Area", String(country.area), false),
                ("Population", String(country.population.population) + " (" + String(country.population.year) + ")", false),
                ("Country Code", country.code, false),
                ("Currency", country.currency, false)]
    }
    
    private var capitalData: [CountryDataRow] {
        return [("Name", country.capital.name[Utils.userLang]!, true),
                ("Latitude", String(format: "%4f", country.capital.coordinate.latitude), false),
                ("Longitude", String(format: "%4f", country.capital.coordinate.longitude), false)]
    }
    
    private var joinedData: [CountryDataRow] {
        var ret: [CountryDataRow] = []
        ret.append(("Union", Utils.defaultDateFormatter.string(from: Utils.isoDateFormatter.date(from: country.joined.union)!), false))
        if !country.joined.euro.isEmpty {
            ret.append(("Euro", Utils.defaultDateFormatter.string(from: Utils.isoDateFormatter.date(from: country.joined.euro)!), false))
        }
        if !country.joined.schengen.isEmpty {
            ret.append(("Schengen", Utils.defaultDateFormatter.string(from: Utils.isoDateFormatter.date(from: country.joined.schengen)!), false))
        }
        return ret
    }
}
