import UIKit

@objc protocol ListOrdersRoutingLogic {
    func routeToShowOrder(segue: UIStoryboardSegue?)
    func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ListOrdersDataPassing {
    var dataStore: ListOrdersDataStore? { get }
}

class ListOrdersRouter: NSObject, ListOrdersRoutingLogic, ListOrdersDataPassing {



    weak var viewController: ListOrdersViewController?
    var dataStore: ListOrdersDataStore?
    
    // MARK: Routing

    func routeToShowOrder(segue: UIStoryboardSegue?) {
        let destinationVC = ShowOrderViewController(nibName: nil, bundle: nil)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
    
    func routeToSomewhere(segue: UIStoryboardSegue?) { }
    
    // MARK: Navigation
    
    func navigateToSomewhere(source: ListOrdersViewController, destination: ShowOrderViewController)
    {
      source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToSomewhere(source: ListOrdersDataStore, destination: inout ShowOrderDataStore)
    {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.order = source.orders?[selectedRow!]
    }
}
