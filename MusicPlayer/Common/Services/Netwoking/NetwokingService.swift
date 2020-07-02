//
//  NetwokingService.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/6/30.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import Combine

protocol NetworkingService {
    var session: URLSession { get }
    var bgQueue: DispatchQueue { get }
}

extension NetworkingService {
    func call<Value>(endpoint: APIService, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error>
        where Value: Decodable {
        do {
            let request = try endpoint.makeRequest()
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        return tryMap {
                assert(!Thread.isMainThread)
                guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                    throw NetworkingError.unexpectedResponse
                }
                guard httpCodes.contains(code) else {
                    throw NetworkingError.httpCode(code)
                }
                return $0.0
            }
            .extractUnderlyingError()
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

