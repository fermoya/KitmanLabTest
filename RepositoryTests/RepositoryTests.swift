//
//  RepositoryTests.swift
//  RepositoryTests
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import XCTest
import Mockingjay
import Domain
@testable import Repository

class RepositoryTests: XCTestCase {

    private let repository = Webservice()
    

    func test_LoginOk() {
        let loginExpectation = expectation(description: "login OK")
        var output = false
        repository.login(email: "username", password: "password") { (result) in
            if case .success(true) = result {
                output = true
                loginExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
        XCTAssert(output)
    }
    
    func test_AthletesOk() {
        let athletesExpectation = expectation(description: "athletes OK")
        var output: [Domain.Athlete] = []
        repository.fetchAthletes { (result) in
            switch result {
            case .success(let athletes):
                output = athletes
                athletesExpectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertFalse(output.isEmpty)
        XCTAssertFalse(output.first!.squads.isEmpty)
    }
    
    func testLoginKO() {
        let loginExpectation = expectation(description: "login Error bad request")
        stub(uri(Endpoint.login(email: "username",
                                password: "password").relativePath),
             http(400))

        var output: WebserviceError? = nil
        repository.login(email: "username", password: "password") { (result) in
            if case .failure(.badRequest) = result {
                output = .badRequest
                loginExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 3)
        XCTAssertNotNil(output)
        XCTAssertEqual(output!, WebserviceError.badRequest)
    }

}
