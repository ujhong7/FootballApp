//
//  NetworkService.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import Foundation

class NewsNetworkService {
    private let baseURL = "https://openapi.naver.com/v1/search/news.json"
    private let clientId = "dhUqr5wXTDsDoFPkIk2k" // Naver API 클라이언트 ID
    private let clientSecret = "pv0Xmpu9GT" // Naver API 클라이언트 Secret
}

// MARK: - 뉴스 검색
extension NewsNetworkService {
    func fetchNews(query: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(clientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
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
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(newsResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

// MARK: - 유튜브 하이라이트
extension NewsNetworkService {
    
}
