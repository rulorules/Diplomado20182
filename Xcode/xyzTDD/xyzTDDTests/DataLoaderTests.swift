//
//  DataLoader.swift
//  xyzTDDTests
//
//  Created by d182_raul_j on 28/04/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import XCTest
@testable import xyzTDD

class DataLoaderTests: XCTestCase {
       
    func testLoad(){
        let points: [Vector] = DataLoader.load(.res4)
        XCTAssertEqual(453, points.count)
        let firstPoint = Vector(x: -0.0312216, y: 0.126304, z: 0.00514924)
        let lastPoint = Vector(x: -0.0180834, y: 0.0348142, z: 0.0458772)

        XCTAssertEqual(firstPoint,points.first)
        XCTAssertEqual(lastPoint,points.last)
    }
    
    func testLoadAsync(){
    let firstPoint = Vector(x: -0.0312216, y: 0.126304, z: 0.00514924)
    let lastPoint = Vector(x: -0.0180834, y: 0.0348142, z: 0.0458772)
        
    let exp = expectation(description: "Load Async")
    DataLoader.loadAsync(.res4){ points in exp.fulfill()
    
        XCTAssertEqual(453, points.count)
        XCTAssertEqual(firstPoint,points.first)
        XCTAssertEqual(lastPoint,points.last)
    }
    waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testPerformanceExample(){
        self.measure{
            let points: [Vector] = DataLoader.load(.res1)
            XCTAssertEqual(35947, points.count)
        }
    }
    
    }

