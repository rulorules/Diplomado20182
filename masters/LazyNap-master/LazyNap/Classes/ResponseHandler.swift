//
//  ResponseHandler.swift
//  LazyNap
//
//  Created by Luis Ezcurdia on 3/29/18.
//

import Foundation

public typealias boolHandler = (Bool, HTTPURLResponse?) -> Void
public typealias errorHandler = (Error, URLResponse?) -> Void

class ResponseHandler<T> where T: Codable {
    let decoder = JSONDecoder()

    func objectListFrom(data: Data?, response: URLResponse?, error: Error?, completion: @escaping ([T], HTTPURLResponse?) -> Void, errorHandler: errorHandler?) {
        guard error == nil else {
            errorHandler?(error!, response)
            return
        }
        guard let jsonData = data else {
            completion([T](), response as? HTTPURLResponse)
            return
        }
        let decoded = try? decoder.decode([T].self, from: jsonData)
        completion(decoded ?? [T](), response as? HTTPURLResponse)
    }

    func objectFrom(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (T?, HTTPURLResponse?) -> Void, errorHandler: errorHandler?) {
        guard error == nil else {
            errorHandler?(error!, response)
            return
        }
        guard let jsonData = data else {
            completion(nil, response as? HTTPURLResponse)
            return
        }
        let decoded = try? decoder.decode(T.self, from: jsonData)
        completion(decoded, response as? HTTPURLResponse)
    }

    func boolFrom(response: URLResponse?, error: Error?, completion: @escaping (Bool, HTTPURLResponse?) -> Void, errorHandler: errorHandler?) {
        if error != nil {
            errorHandler?(error!, response)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse else { return }
        switch httpResponse.statusCode {
        case 200, 201, 204:
            completion(true, httpResponse)
        default:
            completion(false, httpResponse)
        }
    }
}
