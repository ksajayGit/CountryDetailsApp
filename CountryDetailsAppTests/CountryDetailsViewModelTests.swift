//
//  CountryDetailsViewModelTests.swift
//  CountryDetailsAppTests
//
//  Created by MyHome on 06/07/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import XCTest
@testable import CountryDetailsApp

class CountryDetailsViewModelTests: XCTestCase {

    let mockFact = CountryDetails(
        title: "flag",
        description: nil,
        imageHref: "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
    )
    
    func testShouldVerifyIfCountryDetailsViewModelIsPopulatedProperly() {
        let viewModel = CountryDetailsViewModel(countryDetails: mockFact)
        XCTAssertEqual(viewModel.title, "flag", "incorrect title")
        XCTAssertEqual(viewModel.descriptionText, nil, "incorrect description")
        XCTAssertEqual(viewModel.imageUrl, "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png", "Incorrect url")
    }
}
