//
//  FishService.swift
//  plasticfishes
//
//  Created by Luis Ezcurdia on 8/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class FishService {
    let session: URLSession;
    var urlComponents = URLComponents()
    let decoder = JSONDecoder()
    
    static let shared = FishService(session: URLSession.shared)
    
    init(session: URLSession) {
        self.session = session
        urlComponents.scheme = "https"
        urlComponents.host = "plasticfishes.herokuapp.com"
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func all(completion: @escaping (([Fish]) -> Void)){
        urlComponents.path = "/api/fishes"
        guard let url = urlComponents.url else {
            print("Url not valid")
            return
        }
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            guard let resp = response as? HTTPURLResponse else { return }
            if resp.statusCode == 200, let json = data {
                do {
                    if let fishes = try self?.decoder.decode([Fish].self, from: json) {
                        DispatchQueue.main.async { completion(fishes) }
                    }
                } catch(let err) {
                    print("Parsing Error: \(err)")
                }
            }
        }
        task.resume()
    }
    
    func random(completion: @escaping ((Fish) -> Void)) {
        urlComponents.path = "/api/fishes/random"
        guard let url = urlComponents.url else {
            print("Url not valid")
            return
        }
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            guard let resp = response as? HTTPURLResponse else { return }
            if resp.statusCode == 200, let json = data {
                do {
                    if let fish = try self?.decoder.decode(Fish.self, from: json) {
                        DispatchQueue.main.async { completion(fish) }
                    }
                } catch(let err) {
                    print("Parsing Error: \(err)")
                }
            }
        }
        task.resume()
    }
    
}
