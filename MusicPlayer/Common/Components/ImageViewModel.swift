//
//  ImageViewModel.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/2.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import UIKit

extension ImageView {
    class ViewModel: ObservableObject {
        @Published var image: UIImage?
        
        var url: String = ""
        
        func loadImage() {
            
        }
        
    }
}
