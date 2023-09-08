import UIKit

protocol ListOrdersBusinessLogic {
    func fetchOrders(request: ListOrders.FetchOrders.Request)
}

protocol ListOrdersDataStore {
    var orders: [Order]? { get }
}

class ListOrdersInteractor: ListOrdersBusinessLogic, ListOrdersDataStore {
    var presenter: ListOrdersPresentationLogic?
    var ordersWorker = OrdersWorker(ordersStore: OrdersMemStore())
    var orders: [Order]?
    var worker: ListOrdersWorker?
    
    // MARK: Do something
    
    func fetchOrders(request: ListOrders.FetchOrders.Request) {
        ordersWorker.fetchOrders { orders in
            self.orders = orders
            let response = ListOrders.FetchOrders.Response(orders: orders)
            self.presenter?.presentFetchedOrders(response: response)
        }
    }
}
