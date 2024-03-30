//
//  MainQueueDecorator.swift
//  DesignPatterns
//
//  Created by macbook abdul on 30/03/2024.
//

import Foundation
import UIKit


public protocol UserLoader{
    func fetchUserData(completion:@escaping (String) -> Void)
}


public class RemoteLoader:UserLoader {
    public func fetchUserData(completion:@escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion("user data loaded")
        }
    }
    
    public init(){}
    
}


public class DispatchQueueViewController:UIViewController{
    
    let loader:UserLoader
    public lazy var label: UILabel = {
        let label = UILabel()
        label.text  = "loading"
        return label
    }()
    init(loader: UserLoader) {
        
        self.loader = loader
        super.init(nibName: nil, bundle: nil)
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        label.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(label)
                
                // Add constraints to center the label
                NSLayoutConstraint.activate([
                    label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
         
            loader.fetchUserData { [weak self ]val in
//                DispatchQueue.main.async {
                    self?.label.text = val
//                }
               
            }
             
        
        
       
    }
    
    
}

class MainDispatchQueueDecorator:UserLoader {
    let decoratee:UserLoader
    init(decoratee: UserLoader) {
        self.decoratee = decoratee
    }
    
    func fetchUserData(completion: @escaping (String) -> Void) {
        decoratee.fetchUserData { status in
            self.generatesMainThread {
                completion(status)
            }
        }
    }
    
    func generatesMainThread(completion: @escaping () -> Void){
        if Thread.isMainThread {
            completion()
        }else{
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
}
public class DispatchQueueViewControllerComposer{
    public static func instantiate(loader:UserLoader) -> DispatchQueueViewController {
        
         
        let vc = DispatchQueueViewController(loader: MainDispatchQueueDecorator(decoratee:loader))
        
        return vc
    }
}
//#Preview{
//    DispatchQueueViewController(loader: RemoteLoader())
//}
