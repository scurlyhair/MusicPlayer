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
    @EnvironmentObject var status: PresentationStatus

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: viewModel.cancelBtnTapped, label: {
                    Text("Cancel")
                })
            }
            Spacer()
            Text("Login")
                .padding()
                .font(.headline)
            input(title: "username", text: $viewModel.username)
            input(title: "password", text: $viewModel.password)
            Button(action: viewModel.commitBtnTapped, label: {
                Text("Commit")
            })
            Spacer()
        }
        .padding()
    }

    func input(title: String, text: Binding<String>) -> some View {
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
        LoginView(viewModel: .init())
    }
}
