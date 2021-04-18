//
//  ImageCollectionView.swift
//  TransformingProject
//
//  Created by Karin Prater on 17.04.21.
//

import SwiftUI

struct ImageCollectionView: View {
    
    @StateObject var imageFetcher = ImageCollectionFetcher()
    
    var body: some View {
        
        VStack {
            
            Text("Select image to download")
            
            List(imageFetcher.urlPaths, id: \.self) { path in
                Button(action: {
                    imageFetcher.loadImage.send(path)
                }, label: {
                    Text(path)
                })
            }
            
            List(imageFetcher.images, id: \.self) { (image) in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
        }
    }
}

struct ImageCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCollectionView()
    }
}
