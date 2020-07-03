//
//  Song.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/3.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

struct Song {
    var name: String
}


extension Song: Identifiable {
    var id: String {
        name
    }
}
