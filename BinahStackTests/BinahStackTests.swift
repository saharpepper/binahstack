//
//  BinahStackTests.swift
//  BinahStackTests
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import XCTest
@testable import BinahStack

class BinahStackTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testDatePastExtension() throws {
        let oneSecAgoDate = dateDiff(seconds: 1)
        let oneMinAgoDate = dateDiff(seconds: 1*60)
        let oneHourAgoDate = dateDiff(seconds: 1*60*60)
        let oneDayAgoDate = dateDiff(seconds: 1*60*60*24)
        let oneWeekAgoDate = dateDiff(seconds: 1*60*60*24*7)
        let oneMonthAgoDate = dateDiff(seconds: 1*60*60*24*7*5)
        XCTAssertEqual(oneSecAgoDate.friendlyTimeAgo(), "1 sec ago")
        XCTAssertEqual(oneMinAgoDate.friendlyTimeAgo(), "1 min ago")
        XCTAssertEqual(oneHourAgoDate.friendlyTimeAgo(), "1 hours ago")
        XCTAssertEqual(oneDayAgoDate.friendlyTimeAgo(), "1 days ago")
        XCTAssertEqual(oneWeekAgoDate.friendlyTimeAgo(), "1 weeks ago")
        XCTAssertEqual(oneMonthAgoDate.friendlyTimeAgo(), oneMonthAgoDate.friendlyDate())
    }
    
    private func dateDiff(seconds: TimeInterval) -> Date {
        return Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate - seconds)
    }
}
