import UIKit

protocol ListOrdersPresentationLogic {
    func presentSomething(response: ListOrders.Something.Response)
    func presentFetchedOrders(response: ListOrders.FetchOrders.Response)
}

class ListOrdersPresenter: ListOrdersPresentationLogic {
    func presentFetchedOrders(response: ListOrders.FetchOrders.Response) {
        var displayedOrders: [ListOrders.FetchOrders.ViewModel.DisplayOrder] = []
        for order in response.orders {
            let date = dateFormatter.string(from: order.date)
            let total = currencyFormatter.string(from: order.total)
            let displayedOrder = ListOrders.FetchOrders.ViewModel.DisplayOrder(
                id: order.id ?? "",
                date: date,
                email: order.email,
                name: "\(order.lastName) \(order.firstName)",
                total: total ?? ""
            )
            displayedOrders.append(displayedOrder)
            let viewModel = ListOrders.FetchOrders.ViewModel(displayedOrders: displayedOrders)
            viewController?.displayFetchedOrders(viewModel: viewModel)
        }
    }

    weak var viewController: ListOrdersDisplayLogic?

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()

    // MARK: Do something
    
    func presentSomething(response: ListOrders.Something.Response) {
        let viewModel = ListOrders.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
