//
//  Container.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/4.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import SwiftUI

struct Container: View {
    var body: some View {
        HomeView(viewModel: .init())
            .modifier(PresentationModifier())
    }
}

struct Container_Previews: PreviewProvider {
    static var previews: some View {
        Container().environmentObject(PresentationStatus())
    }
}
