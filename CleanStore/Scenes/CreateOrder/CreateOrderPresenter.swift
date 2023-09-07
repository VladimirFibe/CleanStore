import UIKit

protocol CreateOrderPresentationLogic {
    func presentExpirationDate(response: CreateOrder.FormatExpirationDate.Response)
}

class CreateOrderPresenter: CreateOrderPresentationLogic {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    weak var viewController: CreateOrderDisplayLogic?
    
    // MARK: Do something
    func presentExpirationDate(response: CreateOrder.FormatExpirationDate.Response) {
        let date = dateFormatter.string(from: response.date)
        let viewModel = CreateOrder.FormatExpirationDate.ViewModel(date: date)
        viewController?.displayExpirationDate(viewModel: viewModel)
    }
}
