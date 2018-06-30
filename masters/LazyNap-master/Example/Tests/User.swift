//
//  User.swift
//  LazyNap_Tests
//
//  Created by Luis Ezcurdia on 3/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import LazyNap

struct User: Identifiable, Codable {
    let id: Int?
    let name: String
    let email: String
    let role: String

    init(name: String, email: String) {
        self.init(id: nil, name: name, email: email, role: "user")
    }

    init(id: Int?, name: String, email: String, role: String) {
        self.id = id
        self.name = name
        self.email = email
        self.role = role
    }
}

struct Group: Slugable {
    let slug: String?
}
