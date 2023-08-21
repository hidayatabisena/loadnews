//
//  NetworkManager.swift
//  LoadNews
//
//  Created by Hidayat Abisena on 21/08/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: URL) async throws -> NewsResponse {
        let (data, _) = try await URLSession.shared.data(from: url)
        let articles = try JSONDecoder().decode(NewsResponse.self, from: data)
        return articles
    }
}
