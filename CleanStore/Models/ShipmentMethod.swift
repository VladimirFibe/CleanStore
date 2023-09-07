import Foundation

struct ShipmentMethod {
    enum ShippingSpeed: Int {
        case Standard = 0 // "Standard Shipping"
        case OneDay = 1 // "One-Day Shipping"
        case TwoDay = 2 // "Two-Day Shipping"
    }
    var speed: ShippingSpeed

    func toString() -> String {
        switch speed {
        case .Standard: return "Standard Shipping"
        case .OneDay: return "One-Day Shipping"
        case .TwoDay: return "Two-Day Shipping"
        }
    }
}
