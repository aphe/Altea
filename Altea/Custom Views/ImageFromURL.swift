//
//  ImageFromURL.swift
//  Altea
//
//  Created by Afriyandi Setiawan on 19/11/21.
//

import SwiftUI
import WebKit

struct ImageFromURL: View {
    @ObservedObject var downloader: ImageDownloader
    @State var image:UIImage = UIImage()
    
    init(withURL url:String) {
        downloader = ImageDownloader(stringImageURL: url)
        downloader.request()
    }
    
    var body: some View {
        Image(uiImage: downloader.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

