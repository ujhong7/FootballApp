//
//  NewsResponse.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import Foundation

// 전체 뉴스 응답 모델
struct NewsResponse: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [NewsItem]
}

// 뉴스 아이템 모델
struct NewsItem: Codable {
    let title: String
    let originallink: String
    let link: String
    let description: String
    let pubDate: String
}
