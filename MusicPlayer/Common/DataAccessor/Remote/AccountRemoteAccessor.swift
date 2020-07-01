//
//  AccountRemoteAccessor.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/1.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import Combine

protocol AccountRemoteAccessor: NetworkingService {
    func signIn(token: String) -> AnyPublisher<Account, Error>
}

struct RealAccountRemoteAccessor: AccountRemoteAccessor {
    var session: URLSession
    
    func signIn(token: String) -> AnyPublisher<Account, Error> {
        return call(endpoint: AccountAPI.signIn(token: token))
    }
}
