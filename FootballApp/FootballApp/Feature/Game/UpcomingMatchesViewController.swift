//
//  UpcomingMatchesViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class UpcomingMatchesViewController: UIViewController {
    
    private let tableView = UITableView()
    private let fixtureNetwork = FixtureNetwork()
    private var upcomingFixtures: [Fixture] = [] // 예정된 경기 저장
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        view.backgroundColor = .gray
        
        fetchUpcomingFixtures()
    }
    
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
    
    private func fetchUpcomingFixtures() {
        let league = "39" // 프리미어 리그
        let season = "2024"
        
        fixtureNetwork.getUpcomingFixtures(league: league, season: season) { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                self?.upcomingFixtures = response.response // 예정된 경기 배열에 저장
                DispatchQueue.main.async {
                    self?.tableView.reloadData() // 메인 스레드에서 테이블 뷰 갱신
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
        return upcomingFixtures.count // 예정된 경기 수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        let fixture = upcomingFixtures[indexPath.row]
        
        // 셀 구성: Fixture의 정보를 기반으로 UI 업데이트
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
