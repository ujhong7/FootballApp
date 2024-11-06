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
//                print("❌❌❌❌❌❌❌❌❌❌❌❌")
//                dump("Received JSON: \(jsonString)")
//                print("❌❌❌❌❌❌❌❌❌❌❌❌")
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let DecodingError.dataCorrupted(context) {
                print("🐧 데이터가 손상되었습니다: \(context.debugDescription)")
                print("🐧 코딩 경로: \(context.codingPath)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("🐧 키를 찾을 수 없습니다: \(key.stringValue)")
                print("🐧 코딩 경로: \(context.codingPath)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("🐧 타입이 일치하지 않습니다: \(type)")
                print("🐧 코딩 경로: \(context.codingPath)")
                print("🐧 디버그 설명: \(context.debugDescription)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("🐧 값을 찾을 수 없습니다: \(value)")
                print("🐧 코딩 경로: \(context.codingPath)")
                print("🐧 디버그 설명: \(context.debugDescription)")
            } catch {
                print("🐧 예상치 못한 에러: \(error)")
            }
        }
        task.resume()
    }
}
