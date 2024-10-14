//
//  UpcomingMatchesViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class UpcomingMatchesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let footballService = FootballNetworkService()
    private var upcomingFixtures: [Fixture] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        configureTableView()
        fetchUpcomingFixtures()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .premierLeagueBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func fetchUpcomingFixtures() {
        loadingIndicatorView.show(in: view)
        
        footballService.getUpcomingFixtures(league: premierLeague, season: season2024) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.loadingIndicatorView.hide()
            }
            
            switch result {
            case .success(let response):
                print("🟡🟡🟡🟡🟡🟡🟡🟡")
                dump(response)
                self?.upcomingFixtures = response.response
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching upcoming fixtures: \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension UpcomingMatchesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingFixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
        let fixture = upcomingFixtures[indexPath.row]
        cell.configure(with: fixture)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UpcomingMatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 예정된 경기에 대한 상세 정보를 보여주는 기능 추가 가능
    }
}
