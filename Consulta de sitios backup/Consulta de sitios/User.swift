//
//  User.swift
//  Consulta de sitios
//
//  Created by d182_raul_j on 20/04/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import Foundation

struct User: Encodable {
    let email: String
    let password: String
}


struct UserCreation: Encodable {
    let name: String
    let email: String
    let password: String
}


struct UserContainer: Encodable{
    let user: UserCreation
}
