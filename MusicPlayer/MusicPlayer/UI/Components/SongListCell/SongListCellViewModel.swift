//
//  SongListCellViewModel.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/3.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

extension SongListCell {
    class ViewModel: ObservableObject {
        @Published var name: String
        
        init(name: String) {
            self.name = name
        }
    }
}
