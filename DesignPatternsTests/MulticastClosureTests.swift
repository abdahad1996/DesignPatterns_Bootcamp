//
//  MulticastClosureTests.swift
//  DesignPatternsTests
//
//  Created by macbook abdul on 31/03/2024.
//

import Foundation
import DesignPatterns
import XCTest


class MultiCastClosureTests: XCTestCase {
    func test_view_doesNotGenerateRetainCycles()  {
        let (vc1,vc2,vm) = makeSUT()

      
        
        vc1.loadView()
        vc2.loadView()
        
        
        
        vm.addObserver {[weak vc1 ] val in
            vc1?.dataLabel.text = val
        }
        
        vm.addObserver {[weak vc2 ] val in
            vc2?.dataLabel.text = val
        }
//        vm.addObserver(vc2.updateLabel)
        
        
        vm.triggerClosure("hello everyone")

        

        XCTAssertEqual(vc1.dataLabel.text,"hello everyone")
        XCTAssertEqual(vc2.dataLabel.text,"hello everyone")

 
        
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (MultiCastViewController,MultiCastAnotherViewController,MultiCastClosureViewModel){
        let vc1 = MultiCastViewController()
        trackForMemoryLeaks(vc1,file: file,line: line)

        let vc2 = MultiCastAnotherViewController()
        trackForMemoryLeaks(vc2,file: file,line: line)

        let vm = MultiCastClosureViewModel()
        trackForMemoryLeaks(vm,file: file,line: line)

        
        vc1.viewModel = vm
        vc2.viewModel = vm

        return (vc1,vc2,vm)
    }
    
}
