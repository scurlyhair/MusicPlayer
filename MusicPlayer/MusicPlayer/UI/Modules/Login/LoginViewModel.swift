//
//  LoginViewModel.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/1.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

extension LoginView {
    class ViewModel: ObservableObject {
        @Published var username: String = ""
        @Published var password: String = ""
        
        @Binding var isPresentLogin: Bool
        
        init(isPresentLogin: Binding<Bool> = .constant(false)) {
            _isPresentLogin = isPresentLogin
        }
        
        func bind(isPresentLogin: Binding<Bool>) {
            _isPresentLogin = isPresentLogin
        }
        
        func commitBtnTapped() {
            guard inputValidated() else { return }
            guard let token = password.data(using: .utf8)?.sha256().hexString() else {
                Console.logError("configure token failed!")
                return
            }
            // query
            let publisher = Accessor.db.account.queryAccount(username: username)
            let subscriber = Subscribers.Sink<[Account], Error>(receiveCompletion: { completion in
                if let error = completion.error {
                    Console.logError(error.localizedDescription)
                }
            }) { [weak self] accounts in
                if let account = accounts.first, account.token != token {
                    // password error
                    Console.logError("The password is incorrect!")
                    self?.updatePassword(token: token)
                } else if let account = accounts.first, account.token == token {
                    // sign in
                    self?.signIn()
                } else {
                    // sign up
                    self?.signUp(token: token)
                }
            }
            publisher.subscribe(subscriber)
        }
        
        func cancelBtnTapped() {
            isPresentLogin = false
        }
        
        private func signUp(token: String) {
            let publisher = Accessor.db.account.insertAccount(username: username, token: token)
            let subscriber = Subscribers.Sink<Account, Error>(receiveCompletion: { completion in
                if let error = completion.error {
                    Console.logError(error.localizedDescription)
                }
            }) { [weak self] _ in
                Console.logSuccess("Login success!")
                DispatchQueue.main.async {
                    self?.isPresentLogin = false
                }
            }
            publisher.subscribe(subscriber)
        }
        
        private func signIn() {
            Console.logSuccess("Login Success!")
            DispatchQueue.main.async {
                self.isPresentLogin = false
            }
        }
        
        private func updatePassword(token: String) {
            let publisher = Accessor.db.account.updateAccount(username: username, token: token)
            let subscriber = Subscribers.Sink<Account, Error>(receiveCompletion: { completion in
                if let error = completion.error {
                    Console.logError(error.localizedDescription)
                }
            }) { _ in
                Console.logSuccess("Password changed!")
            }
            publisher.subscribe(subscriber)
        }
        
        private func inputValidated() -> Bool {
            guard username.count > 3 else {
                Console.logError("username should be at least 4 characters!")
                return false
            }
            guard password.count > 3 else {
                Console.logError("password should be at least 4 characters!")
                return false
            }
            return true
        }
    }
}
