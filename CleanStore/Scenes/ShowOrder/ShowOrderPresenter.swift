import UIKit

protocol ShowOrderPresentationLogic {
    func presentSomething(response: ShowOrder.Something.Response)
    func presentOrder(response: ShowOrder.GetOrder.Response)
}

class ShowOrderPresenter: ShowOrderPresentationLogic {
    weak var viewController: ShowOrderDisplayLogic?
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
    
    func presentSomething(response: ShowOrder.Something.Response) {
        let viewModel = ShowOrder.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }

    func presentOrder(response: ShowOrder.GetOrder.Response) {
        let order = response.order
        let date = dateFormatter.string(from: order.date)
        let total = currencyFormatter.string(from: order.total) ?? ""
        let displayedOrder = ShowOrder.GetOrder.ViewModel.DisplayOrder(
            id: order.id ?? "",
            date: date,
            email: order.email,
            name: "\(order.lastName) \(order.firstName)",
            total: total
        )
        let viewModel = ShowOrder.GetOrder.ViewModel(displayedOrder: displayedOrder)
        viewController?.displayOrder(viewModel: viewModel)
    }
}
