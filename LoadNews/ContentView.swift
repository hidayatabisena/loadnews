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
            Picker("News Source", selection: $selectedSource.onChange { newTag in
                Task {
                    await articleVM.loadNews(from: newTag.url)
                }
            }) {
                ForEach(NewsSource.allCases, id: \.self) { source in
                    Text(source.rawValue).tag(source)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            .pickerStyle(SegmentedPickerStyle())
            .task {
                await articleVM.loadNews(from: selectedSource.url)
            }
            
            List(articleVM.articles) { article in
                Text(article.title)
            }
            .task {
                await articleVM.loadNews(from: selectedSource.url)
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


#Preview {
    ContentView()
}
