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
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSortingByAreaDown() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        
        app.navigationBars["EU Members"].buttons["Sort By"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Down"]/*[[".segmentedControls.buttons[\"Down\"]",".buttons[\"Down\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.pickerWheels["Name"].adjust(toPickerWheelValue: "Area")
        app.navigationBars["Sort By"].buttons["Done"].tap()
        
        XCTAssertTrue(app.tables.element.exists)
        XCTAssertTrue(app.tables.element.cells.element(boundBy: 0).exists)
        XCTAssertTrue(app.tables.element.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label == "France")
    }
    
    func testIsSoBroken() {
        let app = XCUIApplication()
        
        app.navigationBars["EU Members"].buttons["Sort By"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Down"]/*[[".segmentedControls.buttons[\"Down\"]",".buttons[\"Down\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.pickerWheels["Name"].adjust(toPickerWheelValue: "Area")
        app.navigationBars["Sort By"].buttons["Done"].tap()
        
        XCTAssertTrue(app.tables.element.exists)
        XCTAssertTrue(app.tables.element.cells.element(boundBy: 0).exists)
        XCTAssertTrue(app.tables.element.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label == "Swahili")
    }
}
