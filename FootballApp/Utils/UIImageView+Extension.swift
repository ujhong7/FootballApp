//
// UIImageView+Extension.swift
// FootballApp
//
// Created by yujaehong on 10/11/24.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        ImageCacheManager.shared.loadImage(from: urlString) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
