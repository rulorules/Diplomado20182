//
//  ConfigurableServices.swift
//  LazyNap
//
//  Created by Luis Ezcurdia on 3/29/18.
//

import Foundation

public protocol NapConfig {
    var session: URLSession { get }
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var auth: Authentication? { get }
}

class NapConfigDefault: NapConfig {
    let session: URLSession = URLSession.shared
    let scheme: String = "https"
    let host: String
    let port: Int? = nil
    let auth: Authentication?

    convenience init(host: String) {
        self.init(host: host, auth: nil)
    }

    init(host: String, auth: Authentication?) {
        self.host = host
        self.auth = auth
    }
}
