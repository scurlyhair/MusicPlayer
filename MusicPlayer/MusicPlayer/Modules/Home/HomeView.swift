//
//  HomeView.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/2.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: viewModel.presentLogin) {
                        Text("Account")
                    }
                }
                SongListView(viewModel: .init())
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .padding()
        }
        .sheet(isPresented: $viewModel.isPresentLogin, onDismiss: {
            self.viewModel.isPresentLogin = false
        }, content: {
            LoginView(viewModel: .init())
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init())
    }
}
