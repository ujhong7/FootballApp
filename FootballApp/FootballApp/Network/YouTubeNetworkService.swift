//
//  YouTubeNetworkService.swift
//  FootballApp
//
//  Created by yujaehong on 10/8/24.
//

import Foundation

class YouTubeNetworkService {
    private let highlightsBaseURL = "https://www.googleapis.com/youtube/v3/playlistItems"
    private let commentsBaseURL = "https://www.googleapis.com/youtube/v3/commentThreads"
    private let apiKey = "AIzaSyBMpCZV5u5gE1jijq_g6BrA5OIPtkI-H8c"

    // MARK: - 유튜브 하이라이트 가져오기
    func fetchHighlights(playlistId: String, completion: @escaping (Result<YouTubeResponse, Error>) -> Void) {
        let urlString = "\(highlightsBaseURL)?part=snippet&playlistId=\(playlistId)&maxResults=50&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 1002, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let youtubeResponse = try decoder.decode(YouTubeResponse.self, from: data)
                completion(.success(youtubeResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - 유튜브 댓글 가져오기
    func fetchComments(videoId: String, completion: @escaping (Result<YouTubeCommentResponse, Error>) -> Void) {
        let urlString = "\(commentsBaseURL)?part=snippet&videoId=\(videoId)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 1002, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let commentResponse = try decoder.decode(YouTubeCommentResponse.self, from: data)
                completion(.success(commentResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
