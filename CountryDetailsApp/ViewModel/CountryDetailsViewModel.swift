//
//  CountryDetailsViewModel.swift
//  CountryDetailsApp
//
//  Created by MyHome on 15/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

class CountryDetailsViewModel: NSObject {
    var title: String?
    var descriptionText: String?
    var imageUrl: String?
    init(countryDetails: CountryDetails) {
        self.title = countryDetails.title
        self.descriptionText = countryDetails.description
        self.imageUrl = countryDetails.imageHref
    }
}
