//
//  SongListViewModel.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/3.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

extension SongListView {
    class ViewModel: ObservableObject {
        @Published var songs: [Song] = []
        
        func load() {
            songs.append(Song.init(name: "\(Date().timeIntervalSince1970)"))
        }
        
    }
}
