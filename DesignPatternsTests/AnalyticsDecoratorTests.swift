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
        let (sut,loader) = makeSUT()

      
        
        sut.onAppear()
        
       let values = await loader.loadItem()
    
        

        XCTAssertEqual(values, ["error", "success"])

        
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (AnalyticsView,AnalyticsDecorator){
        let analyticsDecorator = AnalyticsDecorator(decoratee: RemoteItemService(), analyticsTracker:  AnalyticsTracker())
        let composer = AnalyticsComposer.instantiate(serive: analyticsDecorator)
       
        return (composer,analyticsDecorator)
    }
    
}

