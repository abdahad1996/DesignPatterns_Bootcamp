//
//  MulticastClosureTests.swift
//  DesignPatternsTests
//
//  Created by macbook abdul on 31/03/2024.
//

import Foundation
import DesignPatterns
import XCTest


class MultiCastDelegatesTests: XCTestCase {
    func test_view_doesNotGenerateRetainCycles()  {
        let (vc1,vc2,vm) = makeSUT()

      
        
        vc1.loadView()
        vc2.loadView()
        
        vm.addDelegate(vc1)
        vm.addDelegate(vc2)

        
        
        vm.triggerDelegates("hello everyone")

        

        XCTAssertEqual(vc1.dataLabel.text,"hello everyone")
        XCTAssertEqual(vc2.dataLabel.text,"hello everyone")

 
        
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (MultiCastFirstViewController,MultiCastSecondViewController,MultiCastDelegateViewModel){
        let vc1 = MultiCastFirstViewController()
        trackForMemoryLeaks(vc1,file: file,line: line)
        let vc2 = MultiCastSecondViewController()
        trackForMemoryLeaks(vc2,file: file,line: line)

        let vm = MultiCastDelegateViewModel()
        trackForMemoryLeaks(vm,file: file,line: line)

        vc1.viewModel = vm
        vc2.viewModel = vm

        return (vc1,vc2,vm)
    }
    
}
