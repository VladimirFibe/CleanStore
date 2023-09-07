import UIKit

class CreateOrderSwitchTableViewCell: UITableViewCell {
    static let identifier = "CreateOrderSwitchTableViewCell"

    var isOn: Bool {
        toggle.isOn
    }
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()

    private let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        return toggle
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, toggle])
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

    func configure(with title: String, target: Any?, action: Selector) {
        label.text = title
        toggle.addTarget(target, action: action, for: .valueChanged)
    }

    private func setupViews() {
        contentView.addSubview(stackView)
        label.setContentHuggingPriority(.init(251), for: .horizontal)
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
