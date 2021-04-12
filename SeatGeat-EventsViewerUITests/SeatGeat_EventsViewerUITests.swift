//
//  SeatGeat_EventsViewerUITests.swift
//  SeatGeat-EventsViewerUITests
//
//  Created by David Barsamian on 4/8/21.
//

import XCTest

private enum Identifiers: String {
    case eventCell = "eventCell"
    case eventThumbnail = "eventThumbnail"
    case eventFavoriteIcon = "eventFavoriteIcon"
    case eventTitle = "eventTitle"
    case eventLocation = "eventLocation"
    case eventDate = "eventDate"
    case detailImage = "detailImage"
    case detailTitle = "detailTitle"
    case detailLocation = "detailLocation"
    case detailDate = "detailDate"
}

class SeatGeat_EventsViewerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOpenDetailView() throws {
        let app = XCUIApplication()
        app.launch()
        
        let expectation: [Identifiers] = [.detailDate, .detailLocation, .detailTitle, .detailImage]
        app.cells["eventCell"].firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["\(expectation[0])"].exists, "Date view doesn't exist!")
        XCTAssertTrue(app.staticTexts["\(expectation[1])"].exists, "Location view doesn't exist!")
        XCTAssertTrue(app.staticTexts["\(expectation[2])"].exists, "Title view doesn't exist!")
        XCTAssertTrue(app.images["\(expectation[3])"].exists, "Image view doesn't exist!")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
