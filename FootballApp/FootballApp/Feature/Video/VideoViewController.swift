//
//  VideoViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class VideoViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let youTubeService = YouTubeNetworkService()
    private var youtubeData: [YouTubeItem] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        configureTableView()
        fetchYouTube()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.identifier)
        
        tableView.backgroundColor = .purple
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    
    private func fetchYouTube() {
        /// 재생목록 ID (예: 스포티비 2024/25 프리미어리그 하이라이트 재생목록 ID)
        let playlistId = "PL7MQjbfOyOE00FrDWwrbaTtH7mSZOKnvO"
        
        youTubeService.fetchHighlights(playlistId: playlistId) { [weak self] result in
            switch result {
            case .success(let response):
                dump(response)
                self?.youtubeData = response.items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching YouTube data: \(error)")
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension VideoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtubeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as? VideoTableViewCell else {
            return UITableViewCell()
        }
        
        let videoItem = youtubeData[indexPath.row]
        cell.configure(with: videoItem)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension VideoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVideoVC = DetailVideoViewController()
        detailVideoVC.videoId = youtubeData[indexPath.row].snippet.resourceId.videoId
        navigationController?.pushViewController(detailVideoVC, animated: true)
    }
    
}
