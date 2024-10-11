//
//  YouTubeNetworkService.swift
//  FootballApp
//
//  Created by yujaehong on 10/8/24.
//

import Foundation

final class YouTubeNetworkService {
    
    private let baseURL = "https://www.googleapis.com/youtube/v3"
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "YOUTUBE_API_KEY") as? String ?? "default_value"
    
    func fetchHighlights(playlistId: String, completion: @escaping (Result<YouTubeResponse, Error>) -> Void) {
        let path = "/playlistItems"
        let parameters = [
            "part": "snippet",
            "playlistId": playlistId,
            "maxResults": "50",
            "key": apiKey
        ]
        
        NetworkProvider.shared.request(baseURL: baseURL, path: path, headers: nil, parameters: parameters, completion: completion)
    }
    
    func fetchComments(videoId: String, completion: @escaping (Result<YouTubeCommentResponse, Error>) -> Void) {
        let path = "/commentThreads"
        let parameters = [
            "part": "snippet",
            "videoId": videoId,
            "key": apiKey
        ]
        
        NetworkProvider.shared.request(baseURL: baseURL, path: path, headers: nil, parameters: parameters, completion: completion)
    }
}
