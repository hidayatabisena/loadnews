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

    func loadNews(from url: String) async {
        do {
            let newsURL = URL(string: url)
            let response = try await NetworkManager.shared.fetchData(from: newsURL!)
            self.articles = response.data
        } catch {
            // Handle the error
            self.errorMessage = error.localizedDescription
            print("Failed to load news: \(error)")
        }
    }
}

