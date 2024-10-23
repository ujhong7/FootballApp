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
    case decodingError
    case httpError(statusCode: Int)
    case unknownError
}


final class NetworkProvider {
    
    static let shared = NetworkProvider()
    
    func request<T: Decodable>(
        baseURL: String,
        path: String,
        headers: [String: String]?,
        parameters: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var components = URLComponents(string: "\(baseURL)\(path)")!
        
        if let params = parameters {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // HTTP 응답 상태 코드 확인
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(NetworkError.httpError(statusCode: httpResponse.statusCode)))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // 디버그용으로 받은 JSON 데이터 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                //dump("Received JSON: \(jsonString)")
                print("jsonString: \(jsonString)")
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}
