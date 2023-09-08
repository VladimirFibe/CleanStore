import UIKit

enum ListOrders {
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
}
