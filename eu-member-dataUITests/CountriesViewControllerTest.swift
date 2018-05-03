//
//  CountriesViewControllerTest.swift
//  eu-member-dataUITests
//
//  Created by Tomi Lahtinen on 02/05/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import XCTest

class CountriesViewControllerTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSortingByAreaDown() {
        let app = XCUIApplication()
        
        app.navigationBars["EU Members"].buttons["Sort By"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Down"]/*[[".segmentedControls.buttons[\"Down\"]",".buttons[\"Down\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.pickerWheels["Name"].adjust(toPickerWheelValue: "Area")
        app.navigationBars["Sort By"].buttons["Done"].tap()
        
        XCTAssertTrue(app.tables.element.exists)
        XCTAssertTrue(app.tables.element.cells.element(boundBy: 0).exists)
        XCTAssertTrue(app.tables.element.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label == "France")
    }
}
