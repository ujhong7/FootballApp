//
//  ImageCacheManager.swift
//  FootballApp
//
//  Created by yujaehong on 10/12/24.
//

import UIKit

final class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // 1. 메모리 캐시 확인
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        // 2. 디스크 캐시 확인
        if let cachedImage = loadImageFromDisk(urlString: urlString) {
            cache.setObject(cachedImage, forKey: urlString as NSString)
            completion(cachedImage)
            return
        }
        
        // 3. URL에서 이미지 다운로드
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // 4. 메모리 및 디스크 캐시에 저장
            self.cache.setObject(image, forKey: urlString as NSString)
            self.saveImageToDisk(image: image, urlString: urlString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    // 디스크에 이미지 저장
    private func saveImageToDisk(image: UIImage, urlString: String) {
        let fileManager = FileManager.default
        guard let data = image.pngData() else { return }
        
        let fileURL = getFileURL(urlString: urlString)
        fileManager.createFile(atPath: fileURL.path, contents: data, attributes: nil)
    }
    
    // 디스크에서 이미지 불러오기
    private func loadImageFromDisk(urlString: String) -> UIImage? {
        let fileURL = getFileURL(urlString: urlString)
        guard FileManager.default.fileExists(atPath: fileURL.path),
              let image = UIImage(contentsOfFile: fileURL.path) else {
            return nil
        }
        return image
    }
    
    // 파일 URL 생성
    private func getFileURL(urlString: String) -> URL {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileName = urlString.sha256 // URL을 해시 처리하여 파일 이름으로 사용
        return documentDirectory.appendingPathComponent(fileName)
    }
}

extension String {
    // SHA-256 해시 처리
    var sha256: String {
        guard let data = self.data(using: .utf8) else { return self }
        let hash = data.withUnsafeBytes { bytes -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
