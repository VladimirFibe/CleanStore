import UIKit

@objc protocol ListOrdersRoutingLogic {
    func routeToShowOrder()
    func routeToCreateOrder()
}

protocol ListOrdersDataPassing {
    var dataStore: ListOrdersDataStore? { get }
}

class ListOrdersRouter: NSObject, ListOrdersRoutingLogic, ListOrdersDataPassing {
    
    weak var viewController: ListOrdersViewController?
    var dataStore: ListOrdersDataStore?
    
    // MARK: Routing
    
    func routeToShowOrder() {
        let destinationVC = ShowOrderViewController(nibName: nil, bundle: nil)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        navigateToShowOrder(source: viewController!, destination: destinationVC)
    }
    
    func routeToCreateOrder() {
        let destinationVC = CreateOrderViewController(nibName: nil, bundle: nil)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
        navigateToCreateOrder(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToShowOrder(
        source: ListOrdersViewController,
        destination: ShowOrderViewController
    ) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func navigateToCreateOrder(
        source: ListOrdersViewController,
        destination: CreateOrderViewController
    ) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToShowOrder(
        source: ListOrdersDataStore,
        destination: inout ShowOrderDataStore
    ) {
        if let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row {
            destination.order = source.orders?[selectedRow]
        }
    }
    
    func passDataToCreateOrder(
        source: ListOrdersDataStore,
        destination: inout CreateOrderDataStore
    ) {
    }
}
