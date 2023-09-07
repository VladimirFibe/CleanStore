import UIKit

class ShowOrderFieldsTableViewCell: UITableViewCell {
    static let identifier = "ShowOrderFieldsTableViewCell"
    private let keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [keyLabel, valueLabel].forEach { contentView.addSubview($0)}
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            keyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            valueLabel.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: 16),
            valueLabel.topAnchor.constraint(equalTo: keyLabel.topAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            valueLabel.widthAnchor.constraint(equalTo: keyLabel.widthAnchor)
        ])
    }
    func configure(with key: String?, value: String?) {
        keyLabel.text = key
        valueLabel.text = value
    }

}
