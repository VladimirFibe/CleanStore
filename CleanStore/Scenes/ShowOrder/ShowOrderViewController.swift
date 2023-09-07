import UIKit

protocol ShowOrderDisplayLogic: AnyObject {
    func displaySomething(viewModel: ShowOrder.Something.ViewModel)
    func displayOrder(viewModel: ShowOrder.GetOrder.ViewModel)
}

class ShowOrderViewController: UITableViewController, ShowOrderDisplayLogic {
    func displayOrder(viewModel: ShowOrder.GetOrder.ViewModel) {
        let displayOrder = viewModel.displayedOrder
        values.append(displayOrder.id)
        values.append(displayOrder.date)
        values.append(displayOrder.email)
        values.append(displayOrder.name)
        values.append(displayOrder.total)
        tableView.reloadData()
    }
    var values: [String] = []
    var interactor: ShowOrderBusinessLogic?
    var router: (NSObjectProtocol & ShowOrderRoutingLogic & ShowOrderDataPassing)?
    
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
        let interactor = ShowOrderInteractor()
        let presenter = ShowOrderPresenter()
        let router = ShowOrderRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        tableView.separatorStyle = .none
        tableView.register(
            ShowOrderFieldsTableViewCell.self,
            forCellReuseIdentifier: ShowOrderFieldsTableViewCell.identifier
        )
        navigationItem.title = "Show Order"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOrder()
    }

    private func getOrder() {
        let request = ShowOrder.GetOrder.Request()
        interactor?.getOrder(request: request)
    }
    @objc private func editButtonTapped() {
        print(#function)
    }
    
    // MARK: Do something
        
    func doSomething() {
        let request = ShowOrder.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ShowOrder.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
// MARK: UITableViewDataSource
extension ShowOrderViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        values.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowOrderFieldsTableViewCell.identifier, for: indexPath) as? ShowOrderFieldsTableViewCell else { return UITableViewCell()}
        let field = interactor?.fields[indexPath.row]
        let value = values[indexPath.row]
        cell.configure(with: field, value: value)
        return cell
    }
}
