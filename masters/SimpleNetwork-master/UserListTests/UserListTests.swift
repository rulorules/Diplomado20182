//
//  UserListTests.swift
//  UserListTests
//
//  Created by Luis Ezcurdia on 4/19/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import UserList

class UserListTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCurrentUser() {
        let exp = expectation(description: "Fetch DATA")
        Network.currentUser { (data, response, error) in
            exp.fulfill()
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertNotNil(data)
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testCurrentUserParsed() {
        let exp = expectation(description: "Fetch and Parse DATA")
        Network.currentUserParsed { (user) in
            exp.fulfill()
            XCTAssertEqual(user.id, 1)
            XCTAssertEqual(user.name, "admin")
            XCTAssertEqual(user.email, "admin@example.com")
            XCTAssertEqual(user.role, "admin")
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testMultipart() {
        let exp = expectation(description: "Multipart format request")
        Network.multipart { (data, response, error) in
            exp.fulfill()
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            XCTAssertNotNil(data)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
