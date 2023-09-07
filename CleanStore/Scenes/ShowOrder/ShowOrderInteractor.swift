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
        let response = ShowOrder.GetOrder.Response(order: Order(
            firstName: "Amy",
            lastName: "Apple",
            phone: "111-111-1111",
            email: "amy.apple@clean-swift.com",
            billingAddress: Address(
                street1: "1 Infinite Loop",
                street2: "",
                city: "Cupertino",
                state: "CA",
                zip: "95014"),
            paymentMethod: PaymentMethod(
                creditCardNumber: "1234-123456-1234",
                expirationDate: Date(),
                cvv: "999"),
            shipmentAddress: Address(
                street1: "One Microsoft Way",
                street2: "",
                city: "Redmond",
                state: "WA",
                zip: "98052-7329"),
            shipmentMethod: ShipmentMethod(speed: .OneDay),
            id: "abc123",
            date: Date(),
            total: NSDecimalNumber(string: "1.23")
        ))
        presenter?.presentOrder(response: response)
    }
    func doSomething(request: ShowOrder.Something.Request) {
        worker = ShowOrderWorker()
        worker?.doSomeWork()
        
        let response = ShowOrder.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
