//
//  NetworkProvider.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

final class NetworkProvider {
    
    private let baseURL: String = "https://api-football-v1.p.rapidapi.com/v3"
    private let apiKey: String = "539ee52875msh268d1cc437af06dp1108bcjsndf90ae9968da"
    
    // 공통 GET 요청 메서드
    func fetchData<T: Decodable>(path: String, parameters: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents(string: "\(baseURL)\(path)")!
        if let params = parameters {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
//                print("🚨")
//                print(decodedData)
//                print("🚨")
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
