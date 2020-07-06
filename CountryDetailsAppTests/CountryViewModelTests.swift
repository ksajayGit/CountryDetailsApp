//
//  CountryViewModelTests.swift
//  CountryDetailsAppTests
//
//  Created by MyHome on 06/07/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import XCTest
@testable import CountryDetailsApp

class CountryViewModelTests: XCTestCase {

    func testShuouldVerifyIfViewModelCreatedForGivenServiceResponse() {
        let service = MockCountryService()
        let vm = CountryViewModel(serviceCall: service)
        vm.fetchCountryDetails()
        XCTAssertEqual(vm.countryname, "About Canada", "Title Mismatch")
        XCTAssertEqual(vm.countryDetails?.count, 2, "Invalid Contacts")
    }
}
