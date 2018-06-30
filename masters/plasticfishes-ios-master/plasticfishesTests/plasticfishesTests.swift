//
//  plasticfishesTests.swift
//  plasticfishesTests
//
//  Created by Luis Ezcurdia on 8/26/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import plasticfishes

class plasticfishesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIndex() {
        let session = URLSession.shared
        let service = FishService(session: session)
        
        let exp = expectation(description: "Succesfull parse")
        service.all { data in
            exp.fulfill()
            XCTAssertEqual(14, data.count)
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testRandom() {
        let session = URLSession.shared
        let service = FishService(session: session)
        
        let exp = expectation(description: "Succesfull parse")
        service.random { data in
            exp.fulfill()
            XCTAssertNotNil(data.id)
            XCTAssertNotNil(data.name)
            XCTAssertNotNil(data.text)
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
