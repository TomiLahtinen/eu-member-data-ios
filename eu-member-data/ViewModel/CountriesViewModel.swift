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
    
    init(completed: @escaping () -> () = { }) {
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
}
