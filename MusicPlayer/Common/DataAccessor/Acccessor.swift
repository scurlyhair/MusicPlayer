//
//  Acccessor.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/3.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

struct Accessor {
    private init() {}
    static let remote: RemoteAccessor = configRemote()
    static let db: DataBaseAccessor = configDataBase()
    
    // remote
    private static func configRemote() -> RemoteAccessor {
        let session = configSession()
        let image = RealImageRemoteAccessor(session: session)
        let account = RealAccountRemoteAccessor(session: session)
        return RemoteAccessor(image: image, accout: account)
    }
    private static func configSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    // db
    private static func configDataBase() -> DataBaseAccessor {
        let coreDataStack = CoreDataStack()
        let account = RealAccountLocalAccessor(coreDataStack: coreDataStack)
        return DataBaseAccessor(account: account)
    }
}

// MARK: - Remote

extension Accessor {
    struct RemoteAccessor {
        let image: ImageRemoteAccessor
        let accout: AccountRemoteAccessor
    }
}

// MARK: - DB

extension Accessor {
    struct DataBaseAccessor {
        let account: AccountLocalAccessor
    }
}


