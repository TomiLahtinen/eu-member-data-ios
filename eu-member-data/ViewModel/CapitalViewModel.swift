//
//  CapitalViewModel.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 27/04/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation
import CoreLocation

class CapitalViewModel {
    
    typealias CapitalDistance = (Capital, CLLocationDistance)
    typealias CapitalDistances = [CapitalDistance]
    
    let selectedCountry: Country?
    let loaded: (Countries) -> ()
    let distancesUpdated: () -> ()
    
    var countries: Countries?
    var capitalDistances: CapitalDistances?
    
    init(selected: Country,
         loaded: @escaping (Countries) -> () = { _ in /* NOP */},
         distancesUpdated: @escaping () -> () = { /* NOP */}) {
        self.selectedCountry = selected
        self.loaded = loaded
        self.distancesUpdated = distancesUpdated
        
        DispatchQueue.main.async {
            if let path = Bundle.main.path(forResource: "eudata", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let model = try? Countries.init(data: data)
                    self.countries = model
                    self.loaded(model ?? [])
                } catch {
                    fatalError("Error reading file")
                }
            }
        }
    }
    
    func updateDistances(from location: CLLocation) {
        capitalDistances = countries?
            .map() { (country: Country) -> CapitalDistance in
                let distance = location.distance(from: CLLocation(latitude: country.capital.coordinate.latitude, longitude: country.capital.coordinate.longitude))
                return CapitalDistance(country.capital, distance)
            }
            .sorted() { first, second -> Bool in
                return first.1 < second.1
            }
        debugPrint("capital distances", capitalDistances)
        distancesUpdated()
    }
}
