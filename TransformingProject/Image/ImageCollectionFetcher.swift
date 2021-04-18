//
//  ImageCollectionFetcher.swift
//  TransformingProject
//
//  Created by Karin Prater on 17.04.21.
//

import Foundation
import Combine
import SwiftUI

class ImageCollectionFetcher: ObservableObject {
    
    let urlPaths = ["https://static01.nyt.com/images/2019/10/01/science/00SCI-CATS1/merlin_102054072_34962289-a2a4-4c52-9969-4b2719347e76-superJumbo.jpg?quality=90&auto=webp",
                    "https://via.placeholder.com/600/771796",
                    "https://www.mercurynews.com/wp-content/uploads/2019/11/sjm-l-wedjoan-1113_70214984.jpg?w=1457",
                    "https://via.placeholder.com/150/d32776",
                    "https://via.placeholde.com/150/f66b97"]
    
    let loadImage = CurrentValueSubject<String, Never>("")
    
    @Published var images = [UIImage]()
    var subscriptions = Set<AnyCancellable>()
    
    let apiResource = APIResources()
    
    init() {
        
        loadImage
            .removeDuplicates()
            .compactMap {
                URL(string: $0)
            }
            
            //.buffer(size: 100, prefetch: .byRequest, whenFull: .dropOldest)
            //.flatMap(maxPublishers: .max(2)) { (url)  in
            //.setFailureType(to: APIResources.APIError.self)
            
            .flatMap { url -> AnyPublisher<UIImage, Never> in
                self.apiResource.fetch(url: url)
                    .compactMap {
                        UIImage(data: $0)
                    }
                    .catch { _ in
                        Empty()
                    }
//                    .replaceError(with: UIImage(named: "pink")! )
                    .eraseToAnyPublisher()
            }
           
            .scan([UIImage]()) { (all, next) in
                all + [next]
            }
            .receive(on: DispatchQueue.main)
            .sink {
                print($0)
            } receiveValue: { [unowned self] (images) in
                                self.images = images
            }.store(in: &subscriptions)
        
        
        loadImage.send(urlPaths[0])
        loadImage.send(urlPaths[1])
        loadImage.send(urlPaths[2])
    }
}
