//
//  Network.swift
//  UserList
//
//  Created by Luis Ezcurdia on 4/19/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation
import UIKit

class Network {

    class func currentUser(_ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ioslab.herokuapp.com"
        components.path = "/api/users/current"

        var req = URLRequest(url: components.url!)
        // httpMethod is an string variable that must
        // conform any of the http protocol methods:
        // GET, POST, PUT, PATCH, DELETE, HEADER, OPTIONS
        // default is GET
        req.httpMethod = "GET"

        // httpBody a variable that conform the request body
        // as an optional data
        // default is nil
        // req.httpBody = try? JSONEncoder().encode(user)

        // For authorization via header
        // you can set values with the addValue method
        req.addValue("Basic 19c48aff0dae4a20b5dd2eb322ae37a2", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: req, completionHandler: completion)
        task.resume()
    }

    class func currentUserParsed(_ completion: @escaping (User) -> Void) {
        currentUser { (data, response, error) in
            guard error == nil else {
                print("ERROR: \(error!)")
                return
            }
            guard let unwrappedData = data else {
                print("Empty response")
                return
            }

            let resp = response as! HTTPURLResponse
            if resp.statusCode == 200 {
                do {
                    let parsedJson = try JSONDecoder().decode(User.self, from: unwrappedData)
                    completion(parsedJson)
                } catch let err {
                    print("Unable to parse JSON: \(err)")
                }
            } else {
                print("Unsuccesful request: \(resp)")
            }
        }
    }

    class func multipart(_ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ioslab-sample.herokuapp.com"
        components.path = "/users/current"

        var req = URLRequest(url: components.url!)
        req.httpMethod = "PATCH"
        req.setValue("Basic 19c48aff0dae4a20b5dd2eb322ae37a2", forHTTPHeaderField: "Authorization")

        // START multipart construction
        let boundary = NSUUID().uuidString // the boundary act as a separator per field
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let image = UIImage(named: "tacocat")!
        let imageData = UIImagePNGRepresentation(image)! // transforms the PNG image into the binary repsesentation

        let multipartData = multipartBody(data: imageData, boundary: boundary, fileName: "tacocat.png")

        // multipart requires content length
        req.setValue("\(multipartData.count)", forHTTPHeaderField: "Content-Length")
        req.httpBody = multipartData
        // END multipart construction

        let session = URLSession.shared
        let task = session.dataTask(with: req, completionHandler: completion)
        task.resume()
    }

    class func multipartBody(data imageData: Data, boundary: String, fileName: String) -> Data {
        var bodyData = Data()

        // 1 - Data should start with boundary
        bodyData.append(string: "--\(boundary)\r\n")

        // 2 - image png format for avatar field
        bodyData.append(string: "Content-Disposition: form-data; name=\"avatar\"; filename=\"\(fileName)\"\r\n")
        bodyData.append(string: "Content-Type: image/png\r\n\r\n")
        bodyData.append(imageData)
        bodyData.append(string: "\r\n")

        // 3 - Data should end with boundary
        bodyData.append(string: "--\(boundary)--\r\n")

        return bodyData
    }
}

extension Data {
    mutating func append(string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
