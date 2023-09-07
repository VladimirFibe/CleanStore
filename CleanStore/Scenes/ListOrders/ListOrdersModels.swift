import UIKit

enum ListOrders {
    // MARK: Use cases

    enum FetchOrders {
        struct Request { }
        struct Response {
            var orders: [Order]
        }
        struct ViewModel {
            struct DisplayOrder {
                var id: String
                var date: String
                var email: String
                var name: String
                var total: String
            }
            var displayedOrders: [DisplayOrder]
        }
    }
    
    enum Something {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
