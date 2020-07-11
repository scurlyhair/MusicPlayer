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
        VStack {
            SongListView(viewModel: .init())
            Button(action: viewModel.dataGeneration, label: {
                Text("生成数据").padding()
            })
            Button(action: viewModel.dataMigration, label: {
                Text("版本迁移").padding()
            })
        }
        .onAppear(perform: {
            self.viewModel.bind(isPresentLogin: self.$status.isPresentLogin)
            })
        .navigationBarItems(trailing: configureNavigationBarItemTrailing())
        .navigationBarTitle("Home", displayMode: .large)
        .padding()
    }

    func configureNavigationBarItemTrailing() -> some View {
        return Button(action: viewModel.accountBtnTapped, label: {
            Text("Account").padding()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init()).environmentObject(PresentationStatus())
    }
}
