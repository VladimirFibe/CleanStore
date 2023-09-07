import UIKit

protocol ShowOrderBusinessLogic {
    var fields: [String] { get }
    func getOrder(request: ShowOrder.GetOrder.Request)
    func doSomething(request: ShowOrder.Something.Request)
}

protocol ShowOrderDataStore {
    var order: Order! { get set}
}

class ShowOrderInteractor: ShowOrderBusinessLogic, ShowOrderDataStore {
    var fields: [String] = [
        "Order ID:",
        "Order Date:",
        "Email Address:",
        "Your Name:",
        "Order Total:"
    ]

    var presenter: ShowOrderPresentationLogic?
    var order: Order!
    var worker: ShowOrderWorker?
    
    // MARK: Do something
    func getOrder(request: ShowOrder.GetOrder.Request) {
        if let order {
            let response = ShowOrder.GetOrder.Response(order: order)
            presenter?.presentOrder(response: response)
        } else {
            print("nil")
        }
    }
    func doSomething(request: ShowOrder.Something.Request) {
        worker = ShowOrderWorker()
        worker?.doSomeWork()
        
        let response = ShowOrder.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
