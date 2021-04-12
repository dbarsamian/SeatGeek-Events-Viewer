//
//  SeatGeat_EventsViewerTests.swift
//  SeatGeat-EventsViewerTests
//
//  Created by David Barsamian on 4/8/21.
//

import XCTest
@testable import SeatGeat_EventsViewer

class SGEVEventsManagerTests: XCTestCase, EventManagerDelegate {
    var events: SGEventsData?
    var expectation: XCTestExpectation?
    
    override func tearDownWithError() throws {
        expectation = nil
        self.events = nil
    }
    
    func eventManager(_ eventManager: EventManager, didUpdateEvents events: SGEventsData) {
        self.events = events
        expectation?.fulfill()
    }
    
    func eventManager(_ eventManager: EventManager, didFailWithError error: Error) {
        XCTAssert(false, "Event manager returned an error!") // Fail if error received
    }
    
    func testFetchingEvents() throws {
        // Arrange
        var eventManager = EventManager()
        eventManager.delegate = self
        
        // Act
        expectation = expectation(description: "Fetch events")
        eventManager.fetchEvents(page: 1)
        
        // Assert
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(events, "Events did not receive any data!")
    }
    
    func testFetchWithQuery() throws {
        // Arrange
        let query = "Football"
        var eventManager = EventManager()
        eventManager.delegate = self
        
        // Act
        expectation = expectation(description: "Fetch events with query \"Football\"")
        eventManager.fetchEvents(page: 1, with: query)
        
        // Assert
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(events, "Events did not receive any data!")
    }
}
