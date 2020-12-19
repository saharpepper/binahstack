//
//  BinahStackUITests.swift
//  BinahStackUITests
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import XCTest

class BinahStackUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testFilterButton() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        let firstAnsweredQuestionTitle = app.tables.children(matching: .cell).element(boundBy: 0)/*@START_MENU_TOKEN@*/.staticTexts["idQuestionTitleLabel"]/*[[".staticTexts[\"Answered1\"]",".staticTexts[\"idQuestionTitleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertEqual(firstAnsweredQuestionTitle.label, "Answered1")
        
        app.navigationBars["BinahStack"].buttons["Answered"].tap()
        
        let firstUnAnsweredQuestionTitle = app.tables.children(matching: .cell).element(boundBy: 0)/*@START_MENU_TOKEN@*/.staticTexts["idQuestionTitleLabel"]/*[[".staticTexts[\"Answered1\"]",".staticTexts[\"idQuestionTitleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertEqual(firstUnAnsweredQuestionTitle.label, "UnAnswered1")
        
        XCTAssertTrue(app.navigationBars["BinahStack"].buttons["UnAnswered"].exists)
    }
}
