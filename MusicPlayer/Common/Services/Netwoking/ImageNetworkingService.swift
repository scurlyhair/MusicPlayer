//
//  ImageNetworkingService.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/2.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

import Combine
import UIKit

protocol ImageNetworkingService {
    var session: URLSession { get }
    var bgQueue: DispatchQueue { get }
}

extension ImageNetworkingService {
    func loadImage(urlString: String) -> AnyPublisher<UIImage, Error> {
        guard let url = URL(string: urlString) else {
            let error = NetworkingError.invalidURL
            return Fail<UIImage, Error>(error: error).eraseToAnyPublisher()
        }
        return download(rawImageURL: url)
        .subscribe(on: bgQueue)
        .receive(on: DispatchQueue.main)
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
    
    private func download(rawImageURL: URL, requests: [URLRequest] = []) -> AnyPublisher<UIImage, Error> {
        let urlRequest = URLRequest(url: rawImageURL)
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let image = UIImage(data: data)
                    else { throw NetworkingError.imageLoadFailed(requests + [urlRequest]) }
                return image
            }
            .eraseToAnyPublisher()
    }
}
