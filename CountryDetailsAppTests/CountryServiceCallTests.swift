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

    var apiCall: ServiceCalls?
    
    override func setUp() {
        super.setUp()
        apiCall = ServiceCalls()
    }
    
    override func tearDown() {
        apiCall = nil
        super.tearDown()
    }
    
    func testCountriesFetchCall(){
        
        self.apiCall?.getDetails(completion: { (result: Result<Country, Error>) in
            switch result{
                case .success(let country):
                    XCTAssertEqual(country.title, "About Canada", "Correct Country title retrived")
                    XCTAssertEqual(country.rows.count, 14, "Correct Country Details retrived")
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
            }
        })
    }

}
