//
//  User.swift
//  UserList
//
//  Created by Luis Ezcurdia on 4/19/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let role: String
}
