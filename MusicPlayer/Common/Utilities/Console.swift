//
//  Console.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/8.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

struct Console {
    static func logError(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = file.components(separatedBy: "/").last ?? "unknown file"
        print("❌ Error: \(message)\n at \(function) in \(fileName):\(line)")
        #endif
    }
}
