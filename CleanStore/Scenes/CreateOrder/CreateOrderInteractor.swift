import UIKit

protocol CreateOrderBusinessLogic {
    var shippingMethods: [String] { get }
    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request)
}

protocol CreateOrderDataStore {}

class CreateOrderInteractor: CreateOrderBusinessLogic, CreateOrderDataStore {

    var presenter: CreateOrderPresentationLogic?
    var worker: CreateOrderWorker?
    var shippingMethods: [String] = [
        "Standart Shipping",
        "Two-Day Shipping",
        "One-Day Shipping"
    ]

    // MARK: Do something
    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request) {
        let response = CreateOrder.FormatExpirationDate.Response(date: request.date)
        presenter?.presentExpirationDate(response: response)
    }
}
