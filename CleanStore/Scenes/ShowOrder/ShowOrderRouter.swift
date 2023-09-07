import UIKit

@objc protocol ShowOrderRoutingLogic {
    func routeToSomewhere()
}

protocol ShowOrderDataPassing {
    var dataStore: ShowOrderDataStore? { get }
}

class ShowOrderRouter: NSObject, ShowOrderRoutingLogic, ShowOrderDataPassing {
    weak var viewController: ShowOrderViewController?
    var dataStore: ShowOrderDataStore?
    
    // MARK: Routing
    
    func routeToSomewhere() {
//      if let segue = segue {
//        let destinationVC = segue.destination as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//      } else {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
//      }
    }
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: ShowOrderViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ShowOrderDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
