//
//  LoginView.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/1.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            Text("Login")
                .padding()
                .font(.headline)

            createTextField(title: "username", text: $viewModel.username)
            createTextField(title: "password", text: $viewModel.password)
            Button(action: viewModel.commit, label: {
                Text("Commit")
            }).padding()
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func createTextField(title: String, text: Binding<String>) -> some View {
        return TextField(title, text: text)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black, lineWidth: 0.5)
            )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XS"], id: \.self) {
            LoginView(viewModel: .init())
                .previewDevice(PreviewDevice(rawValue: $0))
                .previewDisplayName($0)
        }
    }
}
