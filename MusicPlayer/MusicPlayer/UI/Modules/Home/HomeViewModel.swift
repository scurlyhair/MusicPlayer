//
//  HomeViewModel.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/2.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import SwiftUI

extension HomeView {
    class ViewModel: ObservableObject {
        @Binding var isPresentLogin: Bool
        
        init(isPresentLogin: Binding<Bool> = .constant(false)) {
            _isPresentLogin = isPresentLogin
        }
        
        func bind(isPresentLogin: Binding<Bool>) {
            _isPresentLogin = isPresentLogin
        }
        
        func accountBtnTapped() {
            isPresentLogin = true
        }
    }
}
