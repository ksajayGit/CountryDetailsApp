//
//  ServiceHandler.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

typealias Response = (Result<Data, Error>) -> Void

protocol ServiceHandlerProtocol {
    func handleServiceRequest(url: URL, completion: @escaping Response)
}

struct ServiceHandler: ServiceHandlerProtocol {
    static let sharedHandler = ServiceHandler()
    private var session = URLSession.shared
    private init() { }
    func handleServiceRequest(url: URL, completion: @escaping Response) {
        session.dataTask(with: url) { (data, _, error) in
            if let err = error {
                completion(.failure(err))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(ApplicationError.networkError))
            }
        }.resume()
    }
}
