//
//  ImageView.swift
//  TransformingProject
//
//  Created by Karin Prater on 17.04.21.
//

import SwiftUI

struct ImageView: View {
    @StateObject var imageFetcher = ImageFetcher()
    
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
            
            ZStack {
                Color.gray
                if imageFetcher.image != nil {
                    Image(uiImage: imageFetcher.image!)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
