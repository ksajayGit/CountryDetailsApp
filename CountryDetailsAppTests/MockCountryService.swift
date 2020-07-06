//
//  MockCountryService.swift
//  CountryDetailsAppTests
//
//  Created by MyHome on 06/07/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation
@testable import CountryDetailsApp

struct MockCountryService: CountryServiceProtocol {
    let countryData = Country (
        title: "About Canada",
        rows: [CountryDetails(
            title: "Flag",
            description: nil,
            imageHref: "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
        ), CountryDetails(
            title: "Beavers",
            description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
            imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        )]
    )
    func getDetails<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(Result.success(countryData as! T))
    }
}
