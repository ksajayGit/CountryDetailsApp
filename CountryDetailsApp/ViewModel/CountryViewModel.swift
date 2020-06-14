//
//  CountryViewModel.swift
//  CountryDetailsApp
//
//  Created by MyHome on 15/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

class CountryViewModel: NSObject {
    var countryname: String?
    var countryDetails: [CountryDetailsViewModel]
    
    init(country: Country){
        self.countryname = country.title
        self.countryDetails = country.rows.map({return CountryDetailsViewModel(countryDetails: $0)})
    }
}
