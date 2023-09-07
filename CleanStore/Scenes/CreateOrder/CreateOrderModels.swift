import UIKit

enum CreateOrder {
    // MARK: Use cases
    enum FormatExpirationDate {
        struct Request {
            var date: Date
        }
        struct Response {
            var date: Date
        }
        struct ViewModel {
            var date: String
        }
    }
}
