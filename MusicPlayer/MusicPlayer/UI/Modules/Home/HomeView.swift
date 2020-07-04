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
    @EnvironmentObject var status: PresentationStatus
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.status.isPresentLogin = true
                    }) {
                        Text("Account")
                    }
                }
                SongListView(viewModel: .init())
            }
            .navigationBarTitle("Home")
//            .navigationBarHidden(true)
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init())
    }
}

