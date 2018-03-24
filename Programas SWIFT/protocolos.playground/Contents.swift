//: Playground - noun: a place where people can play

import Cocoa

protocol Queue{
    associatedtype QueueType
    mutating func addItem(item: QueueType)
    mutating func getItem() -> QueueType?
    func count() -> Int
}

struct IntQueue:Queue{
    var items = [Int]()
    mutating func addItem(item: Int) {
        items.append(item)
    }
    
    mutating func getItem() -> Int? {
        return items.remove(at: 0)
    }
    
    func count() -> Int {
        return items.count
    }
}
