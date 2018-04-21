//: [Previous](@previous)

import Foundation

protocol myProtocol{
    associatedtype E
    var items: [E] { get set }
    mutating func addItem(item: E)
}

struct MyStringType: myProtocol{
    var items: [Int] = []
    //typealias E = Int
    mutating func addItem(item: Int) {
        items.append(item)
    }
}

struct MyGenericStruct<T>: myProtocol{
    var items: [T] = []
    mutating func addItem(item: T) {
        items.append(item)
    }
}
//: [Next](@next)
