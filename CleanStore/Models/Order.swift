import Foundation

struct Order: Equatable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }

    // MARK: Contact info
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    
    // MARK: Payment info
    var billingAddress: Address
    var paymentMethod: PaymentMethod
    
    // MARK: Shipping info
    var shipmentAddress: Address
    var shipmentMethod: ShipmentMethod
    
    // MARK: Misc
    var id: String?
    var date: Date
    var total: NSDecimalNumber
}
