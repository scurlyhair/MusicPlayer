//
//  AccountAPI.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/1.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

extension RealAccountRemoteAccessor {
    enum AccountAPI {
        case signIn(username: String, password: String)
    }
}

extension RealAccountRemoteAccessor.AccountAPI: APIService {
    var baseUrl: String {
        return "https://api.github.com"
    }
    
    var path: String {
        switch self {
        case let .signIn(username, password):
            return "/user?username=\(username)&password=\(password)"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
    
}
