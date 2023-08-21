//
//  News.swift
//  LoadNews
//
//  Created by Hidayat Abisena on 21/08/23.
//

import Foundation

// CNN News
struct NewsResponse: Codable {
    let message: String
    let total: Int
    let data: [Article]
}

// List article dari news
struct Article: Codable, Identifiable {
    let title: String
    let link: URL
    let contentSnippet: String
    let isoDate: String
    let image: ImageURLs
    
    // karena di API gak ada id, maka kita bikin custom id
    // supaya nanti bisa ditampilkan sebagai List
    var id: String {
        link.absoluteString
    }
}

struct ImageURLs: Codable {
    let small: URL
    let large: URL
}

// Source News API
enum NewsSource: String, CaseIterable {
    case cnnInternational = "International"
    case cnnEkonomi = "Ekonomi"
    case cnnTeknologi = "Teknologi"
    case cnnHiburan = "Hiburan"
    
    // Ini tag buat masing-masing API
    var url: String {
        switch self {
        case .cnnInternational:
            return "https://berita-indo-api-next.vercel.app/api/cnn-news/internasional"
        case .cnnEkonomi:
            return "https://berita-indo-api-next.vercel.app/api/cnn-news/ekonomi"
        case .cnnTeknologi:
            return "https://berita-indo-api-next.vercel.app/api/cnn-news/teknologi"
        case .cnnHiburan:
            return "https://berita-indo-api-next.vercel.app/api/cnn-news/hiburan"
        }
    }
}
