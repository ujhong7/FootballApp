//
//  GameResultViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class GameResultViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let fixtureNetwork = FixtureNetwork()
    private var fixtures: [Fixture] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        view.backgroundColor = .green
        
        fetchPastFixtures()
    }
    
    // MARK: - Method
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchTableViewCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func fetchPastFixtures() {
        let league = "39" // 프리미어 리그
        let season = "2024"
        
        fixtureNetwork.getPastFixtures(league: league, season: season) { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                self?.fixtures = response.response.reversed() // 배열 반전
                DispatchQueue.main.async {
                    self?.tableView.reloadData() // 메인 스레드에서 테이블 뷰 갱신
                }
            case .failure(let error):
                print("Error fetching fixtures: \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension GameResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        let fixture = fixtures[indexPath.row]
        
        // 셀 구성: Fixture의 정보를 기반으로 UI 업데이트
        let homeTeam = fixture.teams.home
        let awayTeam = fixture.teams.away
        let homeGoals = fixture.goals.home ?? 0
        let awayGoals = fixture.goals.away ?? 0
        let status = fixture.fixture.status.long
        let date = fixture.fixture.date
        
        cell.configure(with: homeTeam.name, homeLogo: homeTeam.logo, awayTeam: awayTeam.name, awayLogo: awayTeam.logo, homeGoals: homeGoals, awayGoals: awayGoals, status: status, date: date)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GameResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

