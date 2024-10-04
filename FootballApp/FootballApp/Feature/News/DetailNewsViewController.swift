//
//  DetailNewsViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit
import WebKit

final class DetailNewsViewController: UIViewController {
    
    private var webView: WKWebView!

    var urlString: String? // URL을 받기 위한 변수

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        setupWebView() // 웹뷰 설정 메서드 호출
        loadWebView() // 웹뷰에 URL 로드
    }
    
    private func setupWebView() {
        webView = WKWebView(frame: view.bounds) // 전체 화면에 웹뷰 설정
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView) // 웹뷰를 뷰에 추가
    }
    
    private func loadWebView() {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return // 유효하지 않은 URL이면 반환
        }
        let request = URLRequest(url: url)
        webView.load(request) // 요청을 통해 웹뷰에 로드
    }
}


