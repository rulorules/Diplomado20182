//
//  Service.swift
//  LazyNap
//
//  Created by Luis Ezcurdia on 3/29/18.
//

import Foundation

public class NapService<T> where T: Codable {
    let path: String
    let config: NapConfig
    let requestBuilder: RequestBuilder
    var cacheEnabled = false

    public typealias indexHandler = ([T], HTTPURLResponse?) -> Void
    public typealias showHandler  = (T?, HTTPURLResponse?) -> Void

    public init(config: NapConfig, path: String) {
        self.config = config
        self.path = path
        self.requestBuilder = RequestBuilder(config: config)
    }

    // GET Index
    public func index(completion: @escaping indexHandler, error errorHandler: errorHandler?) {
        let request = requestBuilder.buildFor(path: self.path, action: "GET", params: nil)
        let task = config.session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.objectListFrom(data: data,
                                   response: response,
                                   error: error,
                                   completion: completion,
                                   errorHandler: errorHandler)
        }
        task.resume()
    }

    // GET Show
    public func show(id: Int, completion: @escaping showHandler, error errorHandler: errorHandler?) {
        show(slug: String(id), completion: completion, error: errorHandler)
    }

    public func show(slug: String, completion: @escaping showHandler, error errorHandler: errorHandler?) {
        let request = requestBuilder.buildFor(path: "\(self.path)/\(slug)", action: "GET", params: nil)
        let task = config.session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.objectFrom(data: data,
                               response: response,
                               error: error,
                               completion: completion,
                               errorHandler: errorHandler)
        }
        task.resume()
    }

    // POST Create
    public func create(resource: T, completion: @escaping showHandler, error errorHandler: errorHandler?) {
        var request = requestBuilder.buildFor(path: self.path, action: "POST", params: nil)
        request.httpBody = try? JSONEncoder().encode(resource)
        let task = config.session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.objectFrom(data: data,
                               response: response,
                               error: error,
                               completion: completion,
                               errorHandler: errorHandler)
        }
        task.resume()
    }

    // PUT Update
    public func update(resource: T, completion: @escaping showHandler, error errorHandler: errorHandler?) {
        guard let id = getId(resource: resource) else { return }
        var request = requestBuilder.buildFor(path: "\(self.path)/\(id)", action: "PUT", params: nil)
        request.httpBody = try? JSONEncoder().encode(resource)
        let task = config.session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.objectFrom(data: data,
                               response: response,
                               error: error,
                               completion: completion,
                               errorHandler: errorHandler)
        }
        task.resume()
    }

    // DELETE Destroy
    public func destroy(resource: T, completion: @escaping boolHandler, error errorHandler: errorHandler?) {
        guard let id = getId(resource: resource) else { return }
        let request = requestBuilder.buildFor(path: "\(self.path)/\(id)", action: "DELETE", params: nil)
        let task = config.session.dataTask(with: request) { (data, response, error) in
            let handler = ResponseHandler<T>()
            handler.boolFrom(response: response,
                             error: error,
                             completion: completion,
                             errorHandler: errorHandler)
        }
        task.resume()
    }

    private func getId(resource: T) -> String? {
        if resource is Identifiable, let id = (resource as? Identifiable)?.id {
            return String(id)
        } else if resource is Slugable {
            return (resource as? Slugable)?.slug
        } else {
            return nil
        }
    }

}
