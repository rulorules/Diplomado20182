//
//  NapServiceTests.swift
//  LazyNap_Tests
//
//  Created by Luis Ezcurdia on 3/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import DVR
import LazyNap

class NapServiceTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIndex() {
        let session = Session(cassetteName: "index")
        let config = Config(session: session)
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "GET Index")

        service.index(completion: { (users, response) in
            XCTAssertEqual(200, response!.statusCode)
            XCTAssertEqual(50, users.count)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testIndexAuthParams() {
        let session = Session(cassetteName: "index.basic_auth_params")
        let config = Config(session: session)
        config.auth = Auth(method: .params, token: "dd9cfeb82e3e47ce8be36baf52f6a5a5")
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "GET Index")

        service.index(completion: { (users, response) in
            XCTAssertEqual(200, response!.statusCode)
            XCTAssertEqual(50, users.count)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testIndexAuth() {
        let session = Session(cassetteName: "index.basic_auth")
        let config = Config(session: session)
        config.auth = Auth(method: .basicHeader, token: "dd9cfeb82e3e47ce8be36baf52f6a5a5")
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "GET Index")

        service.index(completion: { (users, response) in
            XCTAssertEqual(200, response!.statusCode)
            XCTAssertEqual(50, users.count)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testIndexAuthInvalid() {
        let session = Session(cassetteName: "index.basic_auth.401")
        let config = Config(session: session)
        config.auth = Auth(method: .basicHeader, token: "invalid-token-123")
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "GET Index")

        service.index(completion: { (users, response) in
            XCTAssertEqual(401, response!.statusCode)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testShow() {
        let session = Session(cassetteName: "show.200")
        let config = Config(session: session)
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "GET Show")

        service.show(id: 250, completion: { (user, response) in
            XCTAssertEqual(200, response!.statusCode)
            XCTAssertNotNil(user)
            XCTAssertEqual("Joe Doe 250", user!.name)
            XCTAssertEqual("joe.doe250@example.com", user!.email)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testShowNotFound() {
        let session = Session(cassetteName: "show.404")
        let config = Config(session: session)
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "GET Show")

        service.show(id: 9000, completion: { (user, response) in
            XCTAssertEqual(404, response!.statusCode)
            XCTAssertNil(user)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testCreate() {
        let session = Session(cassetteName: "create.201")
        let config = Config(session: session)
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "POST create")
        let user = User(name: "Jane Doe", email: "jane.doe@example.com")

        service.create(resource: user, completion: { (user, response) in
            XCTAssertEqual(201, response!.statusCode)
            XCTAssertNotNil(user)
            XCTAssertEqual(1003, user!.id)
            XCTAssertEqual("Jane Doe", user!.name)
            XCTAssertEqual("jane.doe@example.com", user!.email)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testCreateInvalid() {
        let session = Session(cassetteName: "create.422")
        let config = Config(session: session)
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "POST create")
        let user = User(name: "Jane Doe", email: "not.email.example.com")

        service.create(resource: user, completion: { (user, response) in
            XCTAssertEqual(422, response!.statusCode)
            XCTAssertNil(user)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testUpdate() {
        let session = Session(cassetteName: "update")
        let config = Config(session: session)
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "PUT update")
        let user = User(id: 42, name: "Douglas Adams", email: "douglas.adams@hitchhiker.com", role: "admin")

        service.update(resource: user, completion: { (user, response) in
            XCTAssertEqual(200, response!.statusCode)
            XCTAssertNotNil(user)
            XCTAssertEqual(42, user!.id)
            XCTAssertEqual("Douglas Adams", user!.name)
            XCTAssertEqual("douglas.adams@hitchhiker.com", user!.email)
            XCTAssertEqual("admin", user!.role)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testDestroy() {
        let session = Session(cassetteName: "delete")
        let config = Config(session: session)
        let service = NapService<User>(config: config, path: "/users")

        let indexExpectation = expectation(description: "Delete destroy")
        let user = User(id: 420, name: "Joe Doe 420", email: "joe.doe420@example.com", role: "user")

        service.destroy(resource: user, completion: { (success, response) in
            XCTAssertEqual(204, response!.statusCode)
            XCTAssertTrue(success)
            indexExpectation.fulfill()
        }, error: nil)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
