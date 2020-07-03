//
//  LoginViewModel.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/1.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation

extension LoginView {
    class ViewModel: ObservableObject {
        @Published var username: String = ""
        @Published var password: String = ""
        
        func commit() {
            
        }
    }
}

