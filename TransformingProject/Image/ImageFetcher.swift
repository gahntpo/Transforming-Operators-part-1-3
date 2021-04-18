//
//  ImageFetcher.swift
//  TransformingProject
//
//  Created by Karin Prater on 17.04.21.
//

import Foundation
import Combine
import SwiftUI

class ImageFetcher: ObservableObject {
    
    let urlPaths = ["https://static01.nyt.com/images/2019/10/01/science/00SCI-CATS1/merlin_102054072_34962289-a2a4-4c52-9969-4b2719347e76-superJumbo.jpg?quality=90&auto=webp",
                    "https://via.placeholder.com/600/771796",
                    "https://www.mercurynews.com/wp-content/uploads/2019/11/sjm-l-wedjoan-1113_70214984.jpg?w=1457",
                    "https://via.placeholder.com/150/d32776",
                    "https://via.placeholder.com/150/f66b97"]
    
    @Published var image: UIImage? = nil
    
    
    let loadImage = CurrentValueSubject<String, Never>("")
    
    var subscriptions = Set<AnyCancellable>()
    
    
    init() {
        
        loadImage
            .sink { [unowned self] _  in
            self.image = nil
        }.store(in: &subscriptions)
        
        loadImage
            .removeDuplicates()
            .compactMap {
                URL(string: $0)
            }
            .map { (url)  in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .compactMap {
                        UIImage(data: $0)
                    }
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("completion \(completion)")
            } receiveValue: { [unowned self] (image) in
                self.image = image
            }.store(in: &subscriptions)

        
    }
    
}
