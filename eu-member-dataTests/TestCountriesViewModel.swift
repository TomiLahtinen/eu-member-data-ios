//
//  TestCountriesViewModel.swift
//  eu-member-dataTests
//
//  Created by Tomi Lahtinen on 02/05/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation
import XCTest

@testable import eu_member_data

class CountiresViewModelTest: XCTestCase {
    
    func testLoadViewModel() {
        let countriesLoadExpectation = XCTestExpectation(description: "Load countries from JSON file")
        let  viewModel = CountriesViewModel() {
            countriesLoadExpectation.fulfill()
        }
        viewModel.loadData()
        
        wait(for: [countriesLoadExpectation], timeout: 10.0)
        assert(viewModel.model?.count ?? 0 > 0, "View model has data")
    }
    
    func testSort() {
        let countriesLoadExpectation = XCTestExpectation(description: "Load countries from JSON file")
        let  viewModel = CountriesViewModel() {
            countriesLoadExpectation.fulfill()
        }
        viewModel.loadData()
        wait(for: [countriesLoadExpectation], timeout: 10.0)
        
        let sort = Sort(key: .name, direction: .up)
        viewModel.sort(sort)
        
        assert("Austria" == viewModel.model?.first?.name["en"]!, "Austria is the first")
        assert("United Kingdom" == viewModel.model?.last?.name["en"]!, "UK is the last")
    }
}
