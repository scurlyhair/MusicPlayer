//
//  DBError.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/14.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

enum DBError: Error {
    case contextNotChange
    case itemNotFount
    case custom(message: String)
}

extension DBError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .contextNotChange: return "Context not change!"
        case .itemNotFount: return "Item not found!"
        case .custom(let message): return message
        }
    }
}
