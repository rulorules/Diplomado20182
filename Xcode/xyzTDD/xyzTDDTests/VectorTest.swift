//
//  xyzTDDUITests.swift
//  xyzTDDUITests
//
//  Created by d182_raul_j on 28/04/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import XCTest
@testable import xyzTDD
class VectorTest: XCTestCase {

    func testVector(){
        let vec = Vector(x:1, y:2,z:3)
        XCTAssertNotNil(vec)
        XCTAssertEqual(Float(1), vec.x)
        //XCTAssertEqual(Float(1), vec.y)
        //XCTAssertEqual(Float(1), vec.z)
    }
    
    func testAddition(){
        let vecA = Vector(x: 1, y: 2, z: 3)
        let vecB = Vector(x: 3, y: 2, z: 1)
        let expected = Vector(x: 4, y: 4, z: 4)
        XCTAssertEqual(expected, vecA + vecB)
    }
}
