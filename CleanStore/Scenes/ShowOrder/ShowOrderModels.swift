import UIKit

enum ShowOrder {
    // MARK: Use cases
    enum GetOrder {
        struct Request { }
        struct Response {
            let order: Order
        }
        struct ViewModel {
            struct DisplayOrder {
                var id: String
                var date: String
                var email: String
                var name: String
                var total: String
            }
            var displayedOrder: DisplayOrder
        }
    }
    
    enum Something {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
