//
//  DesignPatternsTests.swift
//  DesignPatternsTests
//
//  Created by macbook abdul on 30/03/2024.
//

import XCTest
import DesignPatterns
import UIKit

class WeakRefTests: XCTestCase {
    func test_view_doesNotGenerateRetainCycles() {
        let sut = makeSUT()

        sut.loadViewIfNeeded()
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> UIViewController {
        let controller = Composer.instantiate()
        trackForMemoryLeaks(controller, file: file, line: line)
        return controller
    }
}

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak!", file: file, line: line)
        }
    }
}
