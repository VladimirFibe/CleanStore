import UIKit

class CreateOrderTextFieldTableViewCell: UITableViewCell {
    static let identifier = "CreateOrderTextFieldTableViewCell"

    var text: String {
        textField.text ?? ""
    }
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    var getTextField: UITextField {
        textField
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String, placeholder: String = "", delegate: UITextFieldDelegate?) {
        label.text = title
        textField.placeholder = placeholder
        textField.delegate = delegate
    }

    func setText(with text: String?) {
        textField.text = text
    }

    private func setupViews() {
        contentView.addSubview(stackView)
        label.setContentHuggingPriority(.init(251), for: .horizontal)
    }

    func configure(with view: UIView) {
        textField.inputView = view
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
