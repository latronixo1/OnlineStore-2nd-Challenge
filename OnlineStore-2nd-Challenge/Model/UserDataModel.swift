//
//  UserDataModel.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let photo: Data
    let name: String
    let email: String
    let password: String
    let gender: String
}
                    
                    
