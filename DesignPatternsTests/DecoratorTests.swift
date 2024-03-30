//
//  DesignPatternsTests.swift
//  DesignPatternsTests
//
//  Created by macbook abdul on 30/03/2024.
//

import XCTest
import DesignPatterns
import UIKit

class MainThreadDecoratorTests: XCTestCase {
    func test_view_passesWhenMainThreadInjectedThroughDecorator() {
        let (sut,loader) = makeSUT()

        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.label.text, "loading")
        
        loader.completions?("jj")
        

        XCTAssertEqual(sut.label.text, "jj")

        
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (DispatchQueueViewController,RemoteLoaderSpy){
        let loader = RemoteLoaderSpy()
        let controller = DispatchQueueViewControllerComposer.instantiate(loader: loader)
        trackForMemoryLeaks(controller, file: file, line: line)
        return (controller,loader)
    }
    
}

class RemoteLoaderSpy:UserLoader{
    var completions : ((String) -> Void)?
    func fetchUserData(completion: @escaping (String) -> Void) {
        completions = completion
      
    }
    
       
}

