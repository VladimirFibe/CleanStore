import UIKit

@objc protocol CreateOrderRoutingLogic {
}

protocol CreateOrderDataPassing {
    var dataStore: CreateOrderDataStore? { get }
}

class CreateOrderRouter: NSObject, CreateOrderRoutingLogic, CreateOrderDataPassing {
    weak var viewController: CreateOrderViewController?
    var dataStore: CreateOrderDataStore?
}
