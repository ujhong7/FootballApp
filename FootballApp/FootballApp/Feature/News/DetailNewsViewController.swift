//
//  DetailNewsViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit
import WebKit

final class DetailNewsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var webView: WKWebView!

    var urlString: String?

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        setupWebView()
        loadWebView()
    }
    
    // MARK: - Methods
    
    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
    }
    
    private func loadWebView() {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return // 유효하지 않은 URL이면 반환
        }
        let request = URLRequest(url: url)
        webView.load(request) 
    }
}


