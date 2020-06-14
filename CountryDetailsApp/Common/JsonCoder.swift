//
//  JSONCoder.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation

struct JsonCoder{
    private let decoder = JSONDecoder()
    
    init(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
        decoder.keyDecodingStrategy = keyDecodingStrategy
    }
    
    func decode<T>(data: Data, completion: (Result<T, Error>) -> Void) where T: Decodable {
        do{
            let decodedObject = try decoder.decode(T.self, from: data)
            completion(.success(decodedObject))
        }catch let e{
            completion(.failure(e))
        }
    }
}
