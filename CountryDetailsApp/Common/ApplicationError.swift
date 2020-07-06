//
//  ApplicationError.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

enum ApplicationError: Error {
    case networkError
    case invalidUrlError
    case invalidResponseData
}
