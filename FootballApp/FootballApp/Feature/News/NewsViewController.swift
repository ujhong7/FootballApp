//
//  NewsViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class NewsViewController: UIViewController {
    
    private let tableView = UITableView()
    private var newsItems: [NewsItem] = [] // 뉴스 아이템 배열
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        configureTableView()
        fetchNews() // 뉴스 데이터 가져오기
    }
    
    // MARK: - Method
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func fetchNews() {
        let newsService = NewsService()
        newsService.fetchNews(query: "PL") { [weak self] result in
            switch result {
            case .success(let newsResponse):
                self?.newsItems = newsResponse.items // 뉴스 아이템 저장
                DispatchQueue.main.async {
                    self?.tableView.reloadData() // 메인 스레드에서 테이블 뷰 갱신
                }
            case .failure(let error):
                print("Error fetching news: \(error)") // 에러 핸들링
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count // 뉴스 아이템 수 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        let newsItem = newsItems[indexPath.row] // 현재 뉴스 아이템
        cell.configure(with: newsItem.title) // 셀에 뉴스 제목 설정
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailNewsViewController()
        detailVC.urlString = newsItems[indexPath.row].link // 선택한 뉴스 아이템의 링크 전달
        navigationController?.pushViewController(detailVC, animated: true) // 상세 뉴스 화면으로 전환
    }
}
