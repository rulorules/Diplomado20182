//
//  IdentifiableTests.swift
//  LazyNap_Tests
//
//  Created by Luis Ezcurdia on 3/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import LazyNap

class IdentifiableTests: XCTestCase {
    let user = User(name: "Joe Doe", email: "joe.doe@example.com")
    let group = Group(slug: "aGroup")

    func testProtocol() {
        XCTAssertFalse(group is Identifiable, "user is not identifiable")
        XCTAssertFalse(user is Slugable, "user is not slugable")
        XCTAssertEqual(nil, user.id)
    }
}
