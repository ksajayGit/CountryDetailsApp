//
//  APIServiceTests.swift
//  CountryDetailsAppTests
//
//  Created by MyHome on 23/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import XCTest
@testable import CountryDetailsApp

class CountryServiceCallTests: XCTestCase {
    let apiCall = ServiceCalls(MockServiceHandler())
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    func testCountriesFetchCall(){
        apiCall.getDetails(completion: { (result: Result<Country, Error>) in
            switch result {
            case .success(let country):
                    XCTAssertEqual(country.title, "About Canada", "InCorrect Country title retrived")
                    XCTAssertEqual(country.rows.count, 14, "InCorrect Country Details retrived")
            case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
            }
        })
    }
}

class MockServiceHandler: ServiceHandlerProtocol {
    func handleServiceRequest(url: URL, completion: @escaping Response) {
        let bundle = Bundle(for: MockServiceHandler.self)
        let fileName = "country"
        if let url = bundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            completion(.success(data))
        }
        completion(.failure(ApplicationError.networkError))
    }
}
