//
//  CountryViewModel.swift
//  CountryDetailsApp
//
//  Created by MyHome on 15/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

class CountryViewModel: NSObject {
    private let countryServiceCall: CountryServiceProtocol
    var countryname: String?
    var countryDetails: [CountryDetailsViewModel]? {
        didSet {
            guard countryDetails != nil else { return }
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var isLoading = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    //MARK: Closures for callback
    var didFinishFetch: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    init(serviceCall: CountryServiceProtocol) {
        self.countryServiceCall = serviceCall
    }
    func fetchCountryDetails(){
        self.countryServiceCall.getDetails(completion: { [weak self] (result: Result<Country, Error>) in
            switch result {
            case .success(let country):
                    self?.countryname = country.title
                    self?.countryDetails = country.rows.map({return CountryDetailsViewModel(countryDetails: $0)})
                    self?.error = nil
                    self?.isLoading = false
            case .failure(let err):
                    self?.error = err
                    self?.isLoading = false
            }
        })
    }
}
