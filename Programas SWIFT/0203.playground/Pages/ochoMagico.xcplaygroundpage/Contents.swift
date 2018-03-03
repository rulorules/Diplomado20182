//: Playground - noun: a place where people can play

import Foundation

func magicEightBall() -> String{
    let random = arc4random_uniform(UInt32(5))
    switch random {
    case 0:
        return "Sí"
    case 1:
        return "No"
    case 2:
        return "Tal vez"
    case 3:
        return "Para nada"
    case 4:
        return "Definitivamente"
    default:
        return "ke"
    }
}

magicEightBall()
magicEightBall()
magicEightBall()
magicEightBall()
