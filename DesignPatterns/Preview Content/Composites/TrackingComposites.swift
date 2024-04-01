//
//  TrackingComposites.swift
//  DesignPatterns
//
//  Created by macbook abdul on 01/04/2024.
//

import Foundation
import UIKit
public protocol EventTracker {
    func track(event: String)
}
public class GoogleAnalyticsTracker: EventTracker {
    public  func track(event: String) {
        print("Log \(event) to GoogleAnalytics")
    }
}
class FirebaseTracker: EventTracker {
    public func track(event: String) {
        print("Log \(event) to Firebase")
    }
}
class MixpanelTracker: EventTracker {
    public func track(event: String) {
        print("Log \(event) to Mixpanel")
    }
}
public class CompositeTracker: EventTracker {
    let trackers: [EventTracker]
    public init(trackers: [EventTracker]) {
        self.trackers = trackers
    }
    public func track(event: String) {
        trackers.forEach { tracker in
            tracker.track(event: event)
        }
    }
}
public class EventTrackerViewController: UIViewController {
    private let tracker: EventTracker
    public var eventTracker:((String) -> Void)?
    public init(tracker: EventTracker) {
        self.tracker = tracker
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        tracker.track(event: "viewDidLoad")
        
    }
    
    public func callApi(){
        tracker.track(event: "call api")
    }
    
    public func buttonTap(){
        eventTracker?("buttonTap")
    }
}
class EventTrackerComposer {
    
   static func instantiate() -> EventTrackerViewController {
       let analyticsTracker = GoogleAnalyticsTracker()
       let firebaseTracker = FirebaseTracker()
       let googleTrackers = CompositeTracker(trackers: [analyticsTracker, firebaseTracker])
       let mixpanelTracker = MixpanelTracker()
       let trackers = CompositeTracker(trackers: [googleTrackers, mixpanelTracker])
       let viewController = EventTrackerViewController(tracker: trackers)
       
//       viewController.eventTracker = analyticsTracker.track
//       viewController.eventTracker = firebaseTracker.track
//       viewController.eventTracker = mixpanelTracker.track
      
       


       return viewController
    }
}
 

#Preview{
    EventTrackerComposer.instantiate()
}
