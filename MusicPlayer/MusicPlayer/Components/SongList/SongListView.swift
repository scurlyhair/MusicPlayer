//
//  SongListView.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/3.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.songs, id: \.id ) { song in
                SongListCell(viewModel: .init(name: song.name))
            }
        }
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(viewModel: .init())
    }
}

