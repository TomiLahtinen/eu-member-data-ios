//
//  CountryViewModel.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 26/04/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation

typealias CountryDataRow = (title: String, value: String)

enum Section: Int {
    case basic
    case capital
    case joined
    
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
    
    func numberOfRowsInSection(section: Section) -> Int {
        switch section {
        case .basic:
            return 2
        case .capital:
            return 0
        case .joined:
            return 0
        }
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
        return [("Area", String(country.area)),
                ("Population", String(country.population.population) + " (" + String(country.population.year) + ")"),
                ("Country Code", country.code),
                ("Currency", country.currency)]
    }
    
    private var capitalData: [CountryDataRow] {
        return []
    }
    
    private var joinedData: [CountryDataRow] {
        return []
    }
}
