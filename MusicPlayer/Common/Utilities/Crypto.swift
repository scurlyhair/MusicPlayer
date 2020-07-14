//
//  Crypto.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/14.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import CommonCrypto

// MARK: - Format 2 String
extension Data {
    func hexString() -> String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
}

// MARK: - SHA256
extension Data {
    func sha256() -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        self.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(self.count), &hash)
        }
        return Data(hash)
    }
}


