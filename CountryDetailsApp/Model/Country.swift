//
//  Country.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

struct Country: Codable {
    let title: String?
    let rows: [CountryDetails]
}
