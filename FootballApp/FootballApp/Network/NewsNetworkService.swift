//
//  NetworkService.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import Foundation

final class NewsNetworkService {
    
    private let baseURL = "https://openapi.naver.com/v1/search/news.json"
    private let clientId =  Bundle.main.object(forInfoDictionaryKey: "NAVER_CLIENT_ID") as? String ?? "default_value"
    private let clientSecret = Bundle.main.object(forInfoDictionaryKey: "NAVER_CLIENT_SECRET") as? String ?? "default_value"
    
    func fetchNews(query: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let parameters = [
            "query": query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        ]
        let headers = [
            "X-Naver-Client-Id": clientId,
            "X-Naver-Client-Secret": clientSecret
        ]
        
        NetworkProvider.shared.request(baseURL: baseURL, path: "", headers: headers, parameters: parameters, completion: completion)
    }
}
