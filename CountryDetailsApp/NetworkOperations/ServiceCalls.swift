//
//  ServiceCalls.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

struct ServiceCalls {
    func getDetails<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void){
        guard let url = URL(string: WEBSERVICE_URL) else { return }
        ServiceHandler.sharedHandler.handleServiceRequest(url: url) { (response) in
            switch(response){
                case .success(let data):
                    let jsonDecoder = JsonCoder()
                    let stringDataValue = String(decoding: data, as: UTF8.self)
                    if let correctedData = stringDataValue.data(using: .utf8){
                        jsonDecoder.decode(data: correctedData) { (result: Result<T, Error>) in
                            switch result {
                                case .success(let dataObject):
                                    completion(.success(dataObject))
                                case .failure(let err):
                                    completion(.failure(err))
                            }
                        }
                    }
                case .failure(let err):
                    completion(.failure(err))
            }
        }
    }
}
