import UIKit

protocol ListOrdersBusinessLogic {
    func fetchOrders(request: ListOrders.FetchOrders.Request)
    func doSomething(request: ListOrders.Something.Request)
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
    
    func doSomething(request: ListOrders.Something.Request) {
        worker = ListOrdersWorker()
        worker?.doSomeWork()
        
        let response = ListOrders.Something.Response()
        presenter?.presentSomething(response: response)
    }

    func fetchOrders(request: ListOrders.FetchOrders.Request) {
        ordersWorker.fetchOrders { orders in
            self.orders = orders
            let response = ListOrders.FetchOrders.Response(orders: orders)
            self.presenter?.presentFetchedOrders(response: response)
        }
    }
}
