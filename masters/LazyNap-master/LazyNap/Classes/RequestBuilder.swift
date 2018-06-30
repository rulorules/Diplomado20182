//
//  RequestBuilder.swift
//  LazyNap
//
//  Created by Luis Ezcurdia on 4/2/18.
//

import Foundation

class RequestBuilder {
    let config: NapConfig

    init(config: NapConfig) {
        self.config = config
    }

    func buildFor(path: String, action: String, params: [String: String]?) -> URLRequest {
        var request = URLRequest(url: self.urlFor(path: path, params: params))
        request.httpMethod = action
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let auth = config.auth {
            switch auth.method {
            case .basicHeader:
                request.setValue("Basic \(auth.token)", forHTTPHeaderField: "Authorization")
            case .bearerHeader:
                request.setValue("Bearer \(auth.token)", forHTTPHeaderField: "Authorization")
            case .params:
                return request
            }
        }
        return request
    }

    private func urlFor(path: String, params: [String: String]?) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.host
        urlComponents.port = config.port
        urlComponents.path = path
        var queryItems = urlComponents.queryItems ?? [URLQueryItem]()
        if let rawQueries = params {
            for (key, value) in rawQueries {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        }
        if let auth = config.auth, auth.method == AuthMethod.params {
            queryItems.append(URLQueryItem(name: "token", value: auth.token))
        }
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }
        return urlComponents.url!
    }
}
