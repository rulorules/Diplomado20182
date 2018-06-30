//
//  Identifiable.swift
//  LazyNap
//
//  Created by Luis Ezcurdia on 3/29/18.
//

import Foundation

public protocol Identifiable {
    var id: Int? { get }
}

public protocol Slugable {
    var slug: String? { get }
}
