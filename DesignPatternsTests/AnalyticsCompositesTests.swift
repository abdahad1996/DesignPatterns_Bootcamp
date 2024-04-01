//
//  DesignPatternsTests.swift
//  DesignPatternsTests
//
//  Created by macbook abdul on 30/03/2024.
//

import XCTest
import DesignPatterns
import UIKit

class AnalyticsCompositesTests: XCTestCase {
    func test_tracker_generatesTracking() {
        let (sut,firebaseTracker,googleTracker) = makeSUT()

      
        
        
        
        sut.loadViewIfNeeded()
        sut.callApi()
        
        
        XCTAssertEqual(firebaseTracker.tracker, ["viewDidLoad", "call api"])
        XCTAssertEqual(googleTracker.tracker, ["viewDidLoad", "call api"])

        
    }
    
    func test_tracker_generatesTrackingWithClosures() {
        let (sut,firebaseTracker,_) = makeSUT()

      
        
        
        sut.eventTracker = firebaseTracker.track
        sut.buttonTap()
        
        
        
        XCTAssertEqual(firebaseTracker.tracker, ["buttonTap"])
        

        
    }
    

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (EventTrackerViewController,FirebaseAnalyticsSpy,GoogleAnalyticsTrackerSpy){
    let firebaseTracker = FirebaseAnalyticsSpy()
    let googleTracker = GoogleAnalyticsTrackerSpy()

    let googleTrackers = CompositeTracker(trackers: [googleTracker,firebaseTracker])
    let trackers = CompositeTracker(trackers: [googleTrackers])
    let viewController = EventTrackerViewController(tracker: trackers)
        
   
        
        return (viewController,firebaseTracker,googleTracker)
    }
    

    
    
}


class GoogleAnalyticsCompositeSpy:EventTracker{
    let trackers: [EventTracker]
    public init(trackers: [EventTracker]) {
        self.trackers = trackers
    }
    func track(event: String) {
        trackers.forEach { eventTracker in
            eventTracker.track(event: event)
        }
    }
}


class GoogleAnalyticsTrackerSpy:EventTracker{
    var tracker = [String]()
    func track(event: String) {
        tracker.append(event) 
    }
    
    
}

class FirebaseAnalyticsSpy:EventTracker{
    var tracker = [String]()
    func track(event: String) {
        tracker.append(event)
    }
    
    
}
