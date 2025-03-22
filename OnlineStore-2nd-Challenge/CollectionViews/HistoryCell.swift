//
//  HistoryCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 03.03.2025.
//


import UIKit

final class HistoryCell: UICollectionViewCell {
    
    private var onDelete: (() -> Void)?
    
    // MARK: - UI Elements
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configuration
    func configure(with history: String, onDelete: @escaping() -> Void) {
        titleLabel.text = history
        self.onDelete = onDelete
    }
    
    @objc private func deleteTapped() {
        onDelete?()
    }
    
    // MARK: - Selection
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemBlue.withAlphaComponent(0.1)
                layer.borderWidth = 1
                layer.borderColor = UIColor.systemBlue.cgColor
            } else {
                backgroundColor = .systemGray6
                layer.borderWidth = 0
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .systemGray6
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
}
