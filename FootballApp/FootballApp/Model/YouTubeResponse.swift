//
//  YouTubeResponse.swift
//  FootballApp
//
//  Created by yujaehong on 10/8/24.
//

import Foundation

// MARK: - 유튜브 응답 모델
struct YouTubeResponse: Codable {
    let items: [YouTubeItem]
}

struct YouTubeItem: Codable {
    let snippet: YouTubeSnippet
}

struct YouTubeSnippet: Codable {
    let title: String
    let description: String
    let thumbnails: YouTubeThumbnails
    let resourceId: YouTubeResourceId
}

struct YouTubeThumbnails: Codable {
    let medium: YouTubeThumbnail
}

struct YouTubeThumbnail: Codable {
    let url: String
}

struct YouTubeResourceId: Codable {
    let kind: String
    let videoId: String
}
