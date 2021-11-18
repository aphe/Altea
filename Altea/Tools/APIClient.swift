//
//  APIClient.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 20/11/21.
//

import Foundation
import Combine

struct APIClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func download(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        let session = URLSession(configuration: .default)
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                return result.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
