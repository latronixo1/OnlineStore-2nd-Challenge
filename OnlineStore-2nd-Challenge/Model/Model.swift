//
//  Model.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import Foundation
// -MARK: PRODUCT

struct Product: Decodable{
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}
struct Rating: Decodable {
    let rate: Double
    let count: Int
}
// -MARK: USER
struct User: Codable, Identifiable {
    let id: Int
    let email: String
    let username: String
    let password: String
    let name: Name
    let phone: String
    let address: Address
}

struct Name: Codable {
    let firstname: String
    let lastname: String
}

struct Address: Codable {
    let geolocation: Geolocation
    let city: String
    let street: String
    let number: Int
    let zipcode: String
}

struct Geolocation: Codable {
    let lat: String
    let long: String
}
