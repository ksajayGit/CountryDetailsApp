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
    var countryDetails: [CountryDetailsViewModel]? {
        didSet{
            guard let _ = countryDetails else { return }
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet{
            self.showAlertClosure?()
        }
    }
    
    var isLoading = false {
        didSet{
            self.updateLoadingStatus?()
        }
    }
    
    //MARK: Closures for callback
    var didFinishFetch: (() -> ())?
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    private var dataServiceCall: ServiceCalls?
    
    init(dataServiceCall: ServiceCalls) {
        self.dataServiceCall = dataServiceCall
    }
    
    func fetchCountryDetails(){
        self.dataServiceCall?.getDetails(completion: { [weak self] (result: Result<Country, Error>) in
            switch result{
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
