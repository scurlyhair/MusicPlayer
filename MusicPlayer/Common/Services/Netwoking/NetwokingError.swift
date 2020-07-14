//
//  NetwokingError.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/1.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

enum NetworkingError: Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case imageLoadFailed([URLRequest])
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageLoadFailed: return "Unable to load image"
        }
    }
}
