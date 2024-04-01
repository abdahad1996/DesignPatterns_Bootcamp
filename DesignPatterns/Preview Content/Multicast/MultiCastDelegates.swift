//
//  MultiCastDelegates.swift
//  DesignPatterns
//
//  Created by macbook abdul on 31/03/2024.
//

import Foundation

// Protocol for the multicast delegate
public protocol MultiCastDelegate: AnyObject {
    func didReceiveMessage(_ message: String)
}

// View model with multicast delegate functionality
public class MultiCastDelegateViewModel {
    // Array to hold multiple delegates
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    public init() {}
    
    // Method to add delegate
    public func addDelegate(_ delegate: MultiCastDelegate) {
        delegates.add(delegate)
    }
    
    // Method to remove delegate
    public func removeDelegate(_ delegate: MultiCastDelegate) {
        delegates.remove(delegate)
    }
    
    // Method to trigger delegate methods
    public func triggerDelegates(_ message: String) {
        for delegate in delegates.allObjects {
            (delegate as? MultiCastDelegate)?.didReceiveMessage(message)
        }
    }
}

import UIKit

// View controller implementing MultiCastDelegate
public class MultiCastFirstViewController: UIViewController, MultiCastDelegate {
    // Label to display the data
    public lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    public var viewModel: MultiCastDelegateViewModel?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // Method called when message is received
    public func didReceiveMessage(_ message: String) {
        dataLabel.text = message
    }
}

public class MultiCastSecondViewController: UIViewController, MultiCastDelegate {
    // Label to display the data
    public lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    public var viewModel: MultiCastDelegateViewModel?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Method called when message is received
    public func didReceiveMessage(_ message: String) {
        dataLabel.text = message
    }
}
