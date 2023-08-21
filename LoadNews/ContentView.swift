//
//  ContentView.swift
//  LoadNews
//
//  Created by Hidayat Abisena on 21/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedSource = NewsSource.cnnInternational
    @ObservedObject var articleVM = ArticleViewModel()
    
    var body: some View {
        VStack {
            Picker("News Source", selection: $selectedSource.onChange { newSource in
                Task {
                    await articleVM.loadNews(from: newSource)
                }
            }) {
                ForEach(NewsSource.allCases, id: \.self) { source in
                    Text(source.rawValue).tag(source)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            .pickerStyle(SegmentedPickerStyle())
            .task {
                await articleVM.loadNews(from: selectedSource)
            }
            
            List(articleVM.articles) { article in
                Text(article.title)
            }
            .task {
                await articleVM.loadNews(from: selectedSource)
            }
        }
        .padding()
    }
}


// MARK: - onChange Picker
// Gunanya untuk me-listen perubahan ketika kita tap Picker segment
// jadi nanti idenya ketika di tap akan memunculkan newValue dari NewsSource
extension Binding where Value: Equatable {
    func onChange(_ handler: @escaping (Value) -> Void) -> Self {
        return Binding(
            get: { self.wrappedValue },
            set: { newValue in
                if self.wrappedValue != newValue {
                    self.wrappedValue = newValue
                    handler(newValue)
                }
            }
        )
    }
}


//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
