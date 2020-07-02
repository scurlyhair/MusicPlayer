//
//  ImageRemoteAccessor.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/2.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol ImageRemoteAccessor: ImageNetworkingService {
    
}

struct RealImageRemoteAccessor: ImageRemoteAccessor {
    var session: URLSession
    
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
}
