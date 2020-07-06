//
//  ServiceCalls.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

protocol CountryServiceProtocol {
    func getDetails<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
}

struct ServiceCalls: CountryServiceProtocol {
    let serviceHandler: ServiceHandlerProtocol
    let jsonCoder = JsonCoder()
    // MARK: initialization
    init(_ serviceHandler: ServiceHandlerProtocol) {
        self.serviceHandler = serviceHandler
    }
    // MARK: Get Country Details method
    func getDetails<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: WEBSERVICE_URL) else {
            completion(.failure(ApplicationError.invalidUrlError))
            return
        }
        makeRequest(url: url, completion: completion)
    }
    // MARK: Service Request
    private func makeRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        ServiceHandler.sharedHandler.handleServiceRequest(url: url) { (response) in
            switch response {
            case .success(let data):
                self.parseData(data: data, completion: completion)
            case .failure(let err):
                    completion(.failure(err))
            }
        }
    }
    // MARK: JSON Decoder and parsing
    private func parseData<T: Decodable>(data: Data, completion: (Result<T, Error>) -> Void) {
        let jsonDecoder = JsonCoder()
        let stringDataValue = String(decoding: data, as: UTF8.self)
        if let correctedData = stringDataValue.data(using: .utf8) {
            jsonDecoder.decode(data: correctedData) { (result: Result<T, Error>) in
                switch result {
                case .success(let dataObject):
                        completion(.success(dataObject))
                case .failure(let err):
                        completion(.failure(err))
                }
            }
        } else {
            completion(.failure(ApplicationError.invalidResponseData))
        }
    }
}
