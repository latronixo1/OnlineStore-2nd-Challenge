//
//  ChipsView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 21.03.2025.
//

import UIKit

final class ChipsView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        layer.cornerRadius = cornerRadius
    }
    
    @available(*, unavailable, message: "unavailable")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ConfigurableViewProtocol
extension ChipsView: ConfigurableViewProtocol {
    func configure(with text: String) {
        titleLabel.text = text
    }
}

// MARK: - Private Methods
private extension ChipsView {
    func setupView() {
        addSubview(titleLabel)
        backgroundColor = .systemGray
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}



