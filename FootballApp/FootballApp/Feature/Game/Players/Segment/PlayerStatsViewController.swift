//
//  PlayerStatsViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/23/24.
//

import UIKit

class PlayerStatsViewController: UIViewController {
    
    // MARK: - init
    
    init(playerID: Int?) {
        self.playerID = playerID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private let playerID: Int?
    private let footballService = FootballNetworkService()
    private var playerResponse: [PlayerResponse] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    private let tableView = UITableView()
    weak var scrollDelegate: ScrollDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureTableView()
        setupTableViewConstraints()
        fetchPlayerStats()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerStatsTableViewCell.self, forCellReuseIdentifier: PlayerStatsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func fetchPlayerStats() {
        loadingIndicatorView.show(in: view)
        if let playerID = playerID {
            footballService.getPlayerProfile(playerID: playerID, season: season2024, league: premierLeague) {
                [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.hide()
                }
                switch result {
                case .success(let response):
                    print("🥸🥸🥸🥸🥸🥸🥸🥸🥸🥸")
                    dump(response)
                    self?.playerResponse = response.response
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching team rankings: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

// MARK: - UITableViewDelegate

extension PlayerStatsViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension PlayerStatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerStatsTableViewCell.identifier, for: indexPath) as! PlayerStatsTableViewCell
        let playerResponse = playerResponse[indexPath.row]
        cell.configure(with: playerResponse)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension PlayerStatsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(yOffset: scrollView.contentOffset.y)
    }
}
