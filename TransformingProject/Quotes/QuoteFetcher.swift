//
//  QuoteFetcher.swift
//  TransformingProject
//
//  Created by Karin Prater on 17.04.21.
//

import Foundation
import Combine

class QuoteFetcher: ObservableObject {
    
    let fileNames = ["quote1", "quote2", "quote3"]
    
    @Published var quotes = [Quote]()

    var subscriptions = Set<AnyCancellable>()
    
    init() {
        //load files with Combine
        
        fileNames.publisher
            .compactMap { fileName -> URL? in
                Bundle.main.url(forResource: fileName, withExtension: "json")
            }
            .tryMap { (url) -> Data in
                try Data(contentsOf: url)
            }
            .decode(type: Quote.self, decoder: JSONDecoder())
          //  .map(\.quoteText)
            .sink { (completion) in
                print("completion with \(completion)")
            } receiveValue: { [unowned self] (quote) in
                self.quotes.append(quote)
            }.store(in: &subscriptions)

        
    }
    
    
}
