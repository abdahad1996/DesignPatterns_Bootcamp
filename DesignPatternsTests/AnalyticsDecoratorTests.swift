//
//  DesignPatternsTests.swift
//  DesignPatternsTests
//
//  Created by macbook abdul on 30/03/2024.
//

import XCTest
import DesignPatterns
import UIKit

class AnalyticsDecoratorTests: XCTestCase {
    func test_view_doesNotGenerateRetainCycles() async {
        let (sut,loader,spy) = makeSUT()

      
        
        
        
       let _ = await loader.loadItem()
    
        
        
        
        XCTAssertEqual( spy.tracker, ["error", "success"])

        
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (AnalyticsView,AnalyticsDecorator,AnalyticsSpy){
        let analyticsSpy = AnalyticsSpy()
        let analyticsDecorator = AnalyticsDecorator(decoratee: RemoteItemService(), analyticsTracker:  analyticsSpy)
        let composer = AnalyticsComposer.instantiate(serive: analyticsDecorator)
       
        return (composer,analyticsDecorator,analyticsSpy)
    }
    

    
    
}

class AnalyticsSpy:Tracker{
    var tracker = [String]()
    func track(values: [String]) {
        tracker = values
    }
    
    
}
