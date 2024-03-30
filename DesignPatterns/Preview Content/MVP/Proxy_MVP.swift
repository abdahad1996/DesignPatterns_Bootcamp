//
//  Proxy_MVP.swift
//  DesignPatterns
//
//  Created by macbook abdul on 29/03/2024.
//

import Foundation
import UIKit

class loader{
    func load() -> [String] {
     return["a","b","c","d"]
    }
}
struct ViewModel{
    let message:[String]
}
protocol AbstractView{
    func display(viewModel:ViewModel)
}

class Presenter{
    let view:AbstractView
    let loader:loader
    
    init(view: AbstractView, loader: loader) {
        self.view = view
        self.loader = loader
    }
    
    func fetch()  {
        print("fetch")
     let a =  loader.load()
        self.view.display(viewModel: ViewModel(message: a))
        
    }
}

class ViewController: UIViewController, AbstractView {
    var presenter: Presenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter?.fetch()
    }

    func display(viewModel: ViewModel) {
        print(viewModel.message)
    }
}

import Foundation

class WeakRefProxy<T: AnyObject> {
    weak var object: T?

    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefProxy: AbstractView where T: AbstractView {
    func display(viewModel: ViewModel) {
        object?.display(viewModel: viewModel)
    }
}
public class Composer{
    public static func instantiate() -> UIViewController {
        let vc = ViewController()
        let loader = loader()
        let presenter = Presenter(view:  WeakRefProxy(vc), loader: loader)
        vc.presenter = presenter
        return vc
    }
}
 

#Preview{
    Composer.instantiate()
}
