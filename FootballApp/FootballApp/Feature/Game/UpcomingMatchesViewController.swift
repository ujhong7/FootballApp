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
    private let fixtureNetwork = FixtureNetwork()
    private var upcomingFixtures: [Fixture] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        configureTableView()
        fetchUpcomingFixtures()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
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
        let league = "39" // 프리미어 리그
        let season = "2024"
        
        fixtureNetwork.getUpcomingFixtures(league: league, season: season) { [weak self] result in
            switch result {
            case .success(let response):
                print("🟡🟡🟡🟡🟡🟡🟡🟡")
                print(response)
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
        
        let homeTeam = fixture.teams.home
        let awayTeam = fixture.teams.away
        let status = fixture.fixture.status.long
        let date = fixture.fixture.date
        
        cell.configure(with: homeTeam.name, homeLogo: homeTeam.logo, awayTeam: awayTeam.name, awayLogo: awayTeam.logo, homeGoals: nil, awayGoals: nil, status: status, date: date) // 점수는 예정된 경기라 nil
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UpcomingMatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 예정된 경기에 대한 상세 정보를 보여주는 기능 추가 가능
    }
}
