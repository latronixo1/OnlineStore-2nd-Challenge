//
//  ConfigurableViewProtocol.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 21.03.2025.
//

protocol ConfigurableViewProtocol {
    associatedtype ConfigurableModel
    func configure(with model: ConfigurableModel)
}
