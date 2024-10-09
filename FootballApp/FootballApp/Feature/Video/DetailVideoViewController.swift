//
//  DetailVideoViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/8/24.
//

import UIKit
import WebKit

final class DetailVideoViewController: UIViewController {
    
    // MARK: - Properties
    
    private var webView: WKWebView!
    private let tableView = UITableView()
    var videoId: String?
    private var comments: [Comment] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        print(videoId)
        setupWebView()
        setupTableView()
        setupLayout()
        loadVideo()
        fetchComments()
    }
    
    // MARK: - Methods
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            tableView.topAnchor.constraint(equalTo: webView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(DetailVideoTableViewCell.self, forCellReuseIdentifier: DetailVideoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = self
        view.addSubview(webView)
    }
    
    private func loadVideo() {
        guard let videoId = videoId else { return }
        let urlString = "https://www.youtube.com/embed/\(videoId)?playsinline=1"  // 인라인 재생을 위한 파라미터 추가
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func fetchComments() {
        guard let videoId = videoId else { return }
        
        let networkService = YouTubeNetworkService()
        networkService.fetchComments(videoId: videoId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.comments = response.items.compactMap { $0.snippet.topLevelComment }
                DispatchQueue.main.async {
                    self.tableView.reloadData() 
                }
            case .failure(let error):
                print("Error fetching comments: \(error)")
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension DetailVideoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailVideoTableViewCell.identifier, for: indexPath) as! DetailVideoTableViewCell
        let comment = comments[indexPath.row]
        cell.configure(with: comment)
        return cell
    }
}

// MARK: - WKUIDelegate

extension DetailVideoViewController: WKUIDelegate {
    
    // WKUIDelegate를 사용하여 전체화면 전환 방지
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return nil  // 새 창이 열리지 않도록 설정
    }
}
