//
//  PresentationModifier.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/4.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import SwiftUI

struct PresentationModifier: ViewModifier {
    @EnvironmentObject var status: PresentationStatus
    
    func body(content: Content) -> some View {
        return content
            .sheet(isPresented: $status.isPresentLogin, content: {
                LoginView(viewModel: .init(isPresentLogin: self.$status.isPresentLogin))
        })
    }
}

// MARK: - Environment Object

class PresentationStatus: ObservableObject {
    @Published var isPresentLogin: Bool = false
}
