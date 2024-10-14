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
    private let roundTabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let footballService = FootballNetworkService()
    private var fixtures: [Fixture] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        configureTableView()
        configureCollectionView()
        setupTableViewHeaderView()
        fetchPastFixtures()
    }
    
    // MARK: - Method
    
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
    
    private func configureCollectionView() {
        roundTabCollectionView.allowsMultipleSelection = false
        roundTabCollectionView.showsHorizontalScrollIndicator = false
        roundTabCollectionView.delegate = self
        roundTabCollectionView.dataSource = self
        roundTabCollectionView.register(RoundCollectionViewCell.self, forCellWithReuseIdentifier: RoundCollectionViewCell.identifier)
        roundTabCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableViewHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)) // 원하는 높이 설정
        headerView.addSubview(roundTabCollectionView)
        
        NSLayoutConstraint.activate([
            roundTabCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            roundTabCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            roundTabCollectionView.topAnchor.constraint(equalTo: headerView.topAnchor),
            roundTabCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        // 테이블 뷰의 헤더로 설정
        tableView.tableHeaderView = headerView
    }
    
    private func fetchPastFixtures() {
        loadingIndicatorView.show(in: view)
        footballService.getPastFixtures(league: premierLeague, season: season2024) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.loadingIndicatorView.hide()
            }
            
            switch result {
            case .success(let response):
                print("🟢🟢🟢🟢🟢🟢🟢🟢🟢")
                print(response)
                self?.fixtures = response.response.reversed()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
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

// MARK: - UICollectionViewDataSource

extension GameResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionViewCell.identifier, for: indexPath) as! RoundCollectionViewCell
        cell.backgroundColor = .blue
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension GameResultViewController: UICollectionViewDelegate {
    
}
