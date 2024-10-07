//
//  GoalsRankingViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class GoalsRankingViewController: UIViewController {
    
    private let tableView = UITableView()
    private let rankingNetwork = RankingNetwork()
    private var scorers: [PlayerRanking] = [] // 득점자 배열 추가
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureTableHeaderView()
        view.backgroundColor = .purple
        fetchTopScorers()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GoalsRankingTableViewCell.self, forCellReuseIdentifier: GoalsRankingTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // 득점자 데이터를 가져오는 메서드
    private func fetchTopScorers() {
        let league = "39" // 프리미어 리그
        let season = "2024"
        
        rankingNetwork.getTopScorers(league: league, season: season) { [weak self] result in
            switch result {
            case .success(let response):
                print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                print(response)
                self?.scorers = response.response // 응답에서 득점자 배열 설정
                DispatchQueue.main.async {
                    self?.tableView.reloadData() // 테이블 뷰 업데이트
                }
            case .failure(let error):
                print("Error fetching top scorers: \(error.localizedDescription)")
            }
        }
    }
    
}

extension GoalsRankingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scorers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalsRankingTableViewCell.identifier, for: indexPath) as? GoalsRankingTableViewCell else {
            return UITableViewCell()
        }
        
        let playerRanking = scorers[indexPath.row]
        cell.configure(with: playerRanking, rank: indexPath.row + 1) // 순위 설정
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GoalsRankingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension GoalsRankingViewController {
    
    private func configureTableHeaderView() {
        // 헤더 뷰의 높이와 넓이를 설정
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        // UI 요소들 생성
        let rankLabel = UILabel()
        let playerNameLabel = UILabel()
        let matchesLabel = UILabel()
        let goalsLabel = UILabel()
        
        // 텍스트 설정
        rankLabel.text = "순위"
        playerNameLabel.text = "이름"
        matchesLabel.text = "경기수"
        goalsLabel.text = "골"
        
        // 폰트 스타일 설정 (선택 사항)
        rankLabel.font = UIFont.boldSystemFont(ofSize: 16)
        playerNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        matchesLabel.font = UIFont.boldSystemFont(ofSize: 16)
        goalsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        // 헤더 뷰에 추가
        headerView.addSubview(rankLabel)
        headerView.addSubview(playerNameLabel)
        headerView.addSubview(matchesLabel)
        headerView.addSubview(goalsLabel)
        
        // 레이아웃 설정
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        matchesLabel.translatesAutoresizingMaskIntoConstraints = false
        goalsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 순위 레이블 위치 설정
            rankLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            rankLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 선수 이름 레이블 위치 설정
            playerNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 95),
            playerNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 경기 수 레이블 위치 설정
            matchesLabel.leadingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -100),
            matchesLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // 골 수 레이블 위치 설정
            goalsLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            goalsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        // 테이블뷰의 tableHeaderView에 설정
        tableView.tableHeaderView = headerView
    }

    
}
