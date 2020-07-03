//
//  SongListCell.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/3.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import SwiftUI

struct SongListCell: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.name)
    }
}

struct SongListCell_Previews: PreviewProvider {
    static var previews: some View {
        SongListCell(viewModel: .init(name: ""))
    }
}
