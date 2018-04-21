//: [Previous](@previous)

import Foundation

precedencegroup ExponentiationPrecedence{
    associativity: left
    higherThan: MultiplicationPrecedence
}
infix operator **: ExponentiationPrecedence
//: [Next](@next)
