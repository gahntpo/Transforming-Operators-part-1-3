//
//  QutoesView.swift
//  TransformingProject
//
//  Created by Karin Prater on 17.04.21.
//

import SwiftUI

struct QuotesView: View {
    
    @StateObject var quotesFetcher = QuoteFetcher()
    
    var body: some View {
        VStack {
        Text("Quotes").font(.title)
         
            List(quotesFetcher.quotes, id: \.self) { quote  in
                
                VStack(alignment: .trailing) {
                    Text(quote.quoteText)
                    Text(quote.author).bold()
                }
            }
        }
    }
}

struct QutoesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView()
    }
}
