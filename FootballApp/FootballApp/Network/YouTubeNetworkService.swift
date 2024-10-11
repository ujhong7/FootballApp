//
//  YouTubeNetworkService.swift
//  FootballApp
//
//  Created by yujaehong on 10/8/24.
//

import Foundation

final class YouTubeNetworkService {
    
    private let baseURL = "https://www.googleapis.com/youtube/v3"
    private let apiKey = "AIzaSyBMpCZV5u5gE1jijq_g6BrA5OIPtkI-H8c"
    
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
