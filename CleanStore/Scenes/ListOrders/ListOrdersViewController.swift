import UIKit

protocol ListOrdersDisplayLogic: AnyObject {
    func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel)
    func displaySomething(viewModel: ListOrders.Something.ViewModel)
}

class ListOrdersViewController: UITableViewController, ListOrdersDisplayLogic {
    var interactor: ListOrdersBusinessLogic?
    var router: (NSObjectProtocol & ListOrdersRoutingLogic & ListOrdersDataPassing)?
    var displayedOrders: [ListOrders.FetchOrders.ViewModel.DisplayOrder] = []
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ListOrdersInteractor()
        let presenter = ListOrdersPresenter()
        let router = ListOrdersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("ready")
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
                print("??? prepare ????")
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrdersOnLoad()
        doSomething()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        navigationItem.title = "List Orders"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
    }

    @objc private func addButtonTapped() {
        let controller = CreateOrderViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: Do something
        
    func doSomething() {
        let request = ListOrders.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ListOrders.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }

    func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel) {
        displayedOrders = viewModel.displayedOrders
        tableView.reloadData()
    }

    private func fetchOrdersOnLoad() {
        let request = ListOrders.FetchOrders.Request()
        interactor?.fetchOrders(request: request)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedOrders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedOrder = displayedOrders[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = displayedOrder.date
        cell.detailTextLabel?.text = displayedOrder.total
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = ShowOrderViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
}
