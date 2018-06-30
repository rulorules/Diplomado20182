//
//  Authentication.swift
//  LazyNap
//
//  Created by Luis Ezcurdia on 3/29/18.
//

import Foundation

public enum AuthMethod {
    case params
    case basicHeader
    case bearerHeader
}

public protocol Authentication {
    var method: AuthMethod { get }
    var token: String { get }
}
