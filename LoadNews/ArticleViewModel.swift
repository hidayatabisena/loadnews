//
//  ArticleViewModel.swift
//  LoadNews
//
//  Created by Hidayat Abisena on 21/08/23.
//

import Foundation

class ArticleViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var errorMessage = ""
    
    // cache article data for better performance
    private var cachedArticles = [NewsSource: [Article]]()
    
    // load from cache
    func loadNews(from source: NewsSource) async {
        if let articles = cachedArticles[source] {
            self.articles = articles
        } else {
            do {
                let newsURL = URL(string: source.url)!
                let response = try await NetworkManager.shared.fetchData(from: newsURL)
                self.articles = response.data
                // Cache the new data
                cachedArticles[source] = self.articles
            } catch {
                self.errorMessage = error.localizedDescription
                print("Failed to load news: \(error)")
            }
        }
    }
    
    //    func loadNews(from url: String) async {
    //        do {
    //            let newsURL = URL(string: url)
    //            let response = try await NetworkManager.shared.fetchData(from: newsURL!)
    //            self.articles = response.data
    //        } catch {
    //            // Handle the error
    //            self.errorMessage = error.localizedDescription
    //            print("Failed to load news: \(error)")
    //        }
    //    }
}

