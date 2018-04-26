//
//  CountriesViewModel.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 21/02/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation

class CountriesViewModel {
    
    var model: Countries?
    let completed: () -> ()
    
    init(completed: @escaping () -> () = {/* NOP */}) {
        self.completed = completed
    }
    
    func loadData() {
        DispatchQueue.main.async {
            if let path = Bundle.main.path(forResource: "eudata", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    try? self.model = Countries.init(data: data)
                    self.completed()
                } catch {
                    fatalError("Error reading file")
                }
            }
        }
    }
    
    func sort(_ sort: Sort) {
        self.model = self.model?.sorted(by: { (c1, c2) -> Bool in
            switch sort.key {
            case .name:
                return sortByName(c1, c2, sort.direction)
            case .area:
                return sort.direction == .up ? c1.area < c2.area : c1.area >= c2.area
            case .population:
                return sort.direction == .up ? c1.population.population < c2.population.population : c1.population.population >= c2.population.population
            case .joinDate:
                return sortByJoinDate(c1, c2, sort.direction)
            }
        })
        
        self.completed()
    }
    
    func sortByName(_ first: Country, _ second: Country, _ direction: SortDirection) -> Bool {
        let firstName = first.name[Utils.userLang] ?? first.name["en"]
        let secondName = second.name[Utils.userLang] ?? second.name["en"]
        guard let _ = firstName, let _ = secondName else {
            fatalError("Missing country name...")
        }
        
        return firstName!.compare(secondName!) == direction.asComparisonResult()
    }
    
    func sortByJoinDate(_ first: Country, _ second: Country, _ direction: SortDirection) -> Bool {
        let date1 = Utils.isoDateFormatter.date(from: first.joined.union) ?? Date()
        let date2 = Utils.isoDateFormatter.date(from: second.joined.union) ?? Date()
        return date1.compare(date2) == direction.asComparisonResult()
    }
}
