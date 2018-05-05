//
//  Vector.swift
//  xyzTDD
//
//  Created by d182_raul_j on 28/04/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import Foundation

struct Vector{
    let x: Float
    let y: Float
    let z: Float
    
    static func +(lhs: Vector, rhs: Vector) -> Vector{
        return Vector(x: lhs.x+rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
}

extension Vector: Equatable{
    static func == (lhs: Vector, rhs: Vector) -> Bool{
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}
