//
//  Config.swift
//  LazyNap_Tests
//
//  Created by Luis Ezcurdia on 3/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import LazyNap

struct Auth: Authentication {
    let method: AuthMethod
    var token: String
}

class Config: NapConfig {
    let session: URLSession
    let scheme: String
    let host: String
    let port: Int?
    var auth: Authentication?

    convenience init(session: URLSession) {
        self.init(session: session, scheme: "http", host: "localhost", port: 3000)
    }

    init(session: URLSession, scheme: String, host: String, port: Int) {
        self.session = session
        self.scheme = scheme
        self.host = host
        self.port = port
    }
}
