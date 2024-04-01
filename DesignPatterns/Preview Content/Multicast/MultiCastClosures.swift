//
//  MultiCastClosures.swift
//  DesignPatterns
//
//  Created by macbook abdul on 31/03/2024.
//

import Foundation


import Foundation

class MulticastClosure<T> {
    private var closures: [ObjectIdentifier: (T) -> Void] = [:]
    
    func addClosure(_ closure: @escaping (T) -> Void) {
        let id = ObjectIdentifier(closure as AnyObject)
        closures[id] = closure
    }
    
    func removeClosure(_ closure: @escaping (T) -> Void) {
        let id = ObjectIdentifier(closure as AnyObject)
        closures.removeValue(forKey: id)
    }
    
    func invoke(_ parameter: T) {
        for closure in closures.values {
            closure(parameter)
        }
    }
}



//// Usage:
//let multicastClosure = MulticastClosure<String>()
//
//let observer1: (String) -> Void = { message in
//    print("Observer 1:", message)
//}
//
//let observer2: (String) -> Void = { message in
//    print("Observer 2:", message)
//}
//
//multicastClosure.addClosure(observer1)
//multicastClosure.addClosure(observer2)
//
//// Invoke the closure
//multicastClosure.invoke("Hello, world!")

// Output:
// Observer 1: Hello, world!
// Observer 2: Hello, world!


public class MultiCastClosureViewModel {
    // Multicast closure for notifying ViewControllers
    private var closureObservers = MulticastClosure<String>()
    public init() {
      
    }
    // Method to add closure observer
    public func addObserver(_ observer: @escaping (String) -> Void) {
        closureObservers.addClosure(observer)
    }
    
    // Method to remove closure observer
    public func removeObserver(_ observer: @escaping (String) -> Void) {
        closureObservers.removeClosure(observer)
    }
    
    // Method to trigger the closure
    public func triggerClosure(_ message: String) {
        closureObservers.invoke(message)
    }
}



import UIKit

public class MultiCastViewController: UIViewController {
    // Label to display the data
    public lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        
        
        return label
    }()
    
    public var viewModel: MultiCastClosureViewModel?

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add closure observer to ViewModel
        viewModel?.addObserver { [weak self] message in
            self?.dataLabel.text = message
        }
    }
    public func updateLabel(_ message: String) {
        dataLabel.text = message
        }
}

public class MultiCastAnotherViewController: UIViewController {
    // Label to display the data
    public lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
    
        
        return label
    }()
    
    public var viewModel: MultiCastClosureViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add closure observer to ViewModel
        viewModel?.addObserver { [weak self] message in
            self?.dataLabel.text = message
        }
    }
    
    public func updateLabel(_ message: String) {
        dataLabel.text = message
        }
    
}

//public class MultiCastClosureViewControllerComposer{
//    public static func instantiate(viewModel:MultiCastViewModel) -> DispatchQueueViewController {
//        
//         
//        let vc = DispatchQueueViewController(loader: MainDispatchQueueDecorator(decoratee:loader))
//        
//        return vc
//    }
//}
