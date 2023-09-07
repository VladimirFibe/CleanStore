import UIKit

protocol CreateOrderDisplayLogic: AnyObject {
    func displayExpirationDate(viewModel: CreateOrder.FormatExpirationDate.ViewModel)
}

class CreateOrderViewController: UITableViewController, CreateOrderDisplayLogic {
    var interactor: CreateOrderBusinessLogic?
    var router: (NSObjectProtocol & CreateOrderRoutingLogic & CreateOrderDataPassing)?

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
        let interactor = CreateOrderInteractor()
        let presenter = CreateOrderPresenter()
        let router = CreateOrderRouter()
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
        configurePickers()
        navigationItem.title = "Create Order"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
    }

    @objc private func saveButtonTapped() {
        print(firstNameCell.text)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 5
        case 3: return 3
        case 4: return billingSwitchCell.isOn ? 1 : 6
        default: return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return firstNameCell
            case 1: return lastNameCell
            case 2: return phoneCell
            default: return emailCell
            }
        case 1:
            switch indexPath.row {
            case 0: return shipmentAddressStreet1Cell
            case 1: return shipmentAddressStreet2Cell
            case 2: return shipmentAddressCityCell
            case 3: return shipmentAddressStateCell
            default: return shipmentAddressZIPCell
            }
        case 2: return shippingMethodCell
        case 3:
            switch indexPath.row {
            case 0: return creditCardNumberCell
            case 1: return expirationDateCell
            default: return ccvCell
            }
        case 4:
            switch indexPath.row {
            case 0: return billingSwitchCell
            case 1: return billingAddressStreet1Cell
            case 2: return billingAddressStreet2Cell
            case 3: return billingAddressCityCell
            case 4: return billingAddressStateCell
            default: return billingAddressZIPCell
            }
        default: return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Customer Contact Info"
        case 1: return "Shipment Address"
        case 2: return "Shipment Method"
        case 3: return "Payment Information"
        case 4: return "Billing Address"
        default: return "Title"
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) {
            for textField in textFields {
                if textField.isDescendant(of: cell) {
                    textField.becomeFirstResponder()
                }
            }
        }
    }

    var textFields: [UITextField] = []
    // MARK: Contact info

    private lazy var firstNameCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "First Name", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var lastNameCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Last Name", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var phoneCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Phone", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var emailCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Email", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    // MARK: Shipping info

    private lazy var shipmentAddressStreet1Cell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Street 1", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var shipmentAddressStreet2Cell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Street 2", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var shipmentAddressCityCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "City", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var shipmentAddressStateCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "State", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var shipmentAddressZIPCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "ZIP", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    // MARK: - Shipping method

    private lazy var shippingMethodCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Shipping Speed", delegate: nil)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var shippingMethodPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private func configurePickers() {
        shippingMethodCell.configure(with: shippingMethodPicker)
        expirationDateCell.configure(with: expirationDatePicker)
    }

    // MARK: - Payment Information

    private lazy var creditCardNumberCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Credit Card Number", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var expirationDateCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Expiration Date", delegate: nil)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var expirationDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.addTarget(
            self,
            action: #selector(expirationDatePickerValueChanged),
            for: .valueChanged
        )
        return datePicker
    }()

    @objc private func expirationDatePickerValueChanged() {
        let date = expirationDatePicker.date
        let request = CreateOrder.FormatExpirationDate.Request(date: date)
        interactor?.formatExpirationDate(request: request)
    }

    func displayExpirationDate(viewModel: CreateOrder.FormatExpirationDate.ViewModel) {
        let date = viewModel.date
        expirationDateCell.setText(with: date)
    }

    private lazy var ccvCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "CVV", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    // MARK: Billing Address

    private lazy var billingSwitchCell: CreateOrderSwitchTableViewCell = {
        let cell = CreateOrderSwitchTableViewCell()
        cell.configure(with: "Same as shipping address", target: self, action: #selector(didTapToggle))
        return cell
    }()

    @objc private func didTapToggle() {
        tableView.reloadData()
    }

    private lazy var billingAddressStreet1Cell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Street 1", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var billingAddressStreet2Cell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "Street 2", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var billingAddressCityCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "City", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var billingAddressStateCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "State", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

    private lazy var billingAddressZIPCell: CreateOrderTextFieldTableViewCell = {
        let cell = CreateOrderTextFieldTableViewCell()
        cell.configure(with: "ZIP", delegate: self)
        textFields.append(cell.getTextField)
        return cell
    }()

}

extension CreateOrderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
        interactor?.shippingMethods.count ?? 0
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String? {
        interactor?.shippingMethods[row]
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        shippingMethodCell.setText(with: interactor?.shippingMethods[row])
        let textField = shippingMethodCell.getTextField
        textField.resignFirstResponder()
    }
}

extension CreateOrderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.firstIndex(of: textField),
           index < textFields.count - 1 {
            let nextTextField = textFields[index + 1]
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}
