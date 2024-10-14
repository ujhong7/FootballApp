//
//  NewsViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let newsService = NewsNetworkService()
    private let tableView = UITableView()
    private var newsItems: [NewsItem] = [] // 뉴스 아이템 배열
    private var searchController: UISearchController!
    private let loadingIndicatorView = LoadingIndicatorView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarUtility.setupNavigationBarAppearance(for: navigationController, backgroundColor: .premierLeaguePurple)
        NavigationTitleUtility.setupNavigationTitle(for: self, title: "뉴스")
        configureTableView()
        configureNavigationBar()
        configureSearchController()
        
        fetchNews() // 뉴스 데이터 가져오기
    }
    
    // MARK: - Method
    
    private func configureTableView() {
        tableView.backgroundColor = .premierLeagueBackgroundColor
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

    private func fetchNews(query: String = "PL") {
        loadingIndicatorView.show(in: view)
        
        newsService.fetchNews(query: query) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.loadingIndicatorView.hide()
            }
            
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
    
    private func configureNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func didTapSearch() {
        present(searchController, animated: true) // 검색 버튼 눌렀을 때 검색창을 모달로 띄움
    }
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search News"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
}

// MARK: - UISearchBarDelegate

extension NewsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        
        // 엔터(검색 버튼) 눌렀을 때 뉴스 데이터 가져오기
        fetchNews(query: query)
        searchController.dismiss(animated: true) // 검색 후 검색창 닫기
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
        cell.configure(with: newsItem) // 셀에 기사 데이터 설정
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
