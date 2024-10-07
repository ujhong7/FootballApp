//
//  AssistsRankingViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class AssistsRankingViewController: UIViewController {
    
    private let tableView = UITableView()
    private let rankingNetwork = RankingNetwork()
    private var assistRankings: [PlayerRanking] = []  // 도움 순위 데이터를 저장할 배열

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        view.backgroundColor = .red
        fetchTopAssists()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AssistsRankingTableViewCell.self, forCellReuseIdentifier: AssistsRankingTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // 도움 순위를 API로부터 가져오는 메서드
      private func fetchTopAssists() {
          let league = "39" // 예: Premier League
          let season = "2024" // 예: 2023 시즌
          
          rankingNetwork.getTopAssists(league: league, season: season) { [weak self] result in
              switch result {
              case .success(let response):
                  // API 호출 성공 시, 데이터 저장 및 테이블 갱신
                  print("🐶🐶🐶🐶🐶")
                  dump(response)
                  self?.assistRankings = response.response
                  DispatchQueue.main.async {
                      self?.tableView.reloadData()
                  }
              case .failure(let error):
                  // 에러 발생 시, 에러 처리
                  print("Error fetching top assists: \(error.localizedDescription)")
              }
          }
      }
   
    
}

extension AssistsRankingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assistRankings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AssistsRankingTableViewCell.identifier, for: indexPath) as? AssistsRankingTableViewCell else {
            return UITableViewCell()
        }
        
        let playerRanking = assistRankings[indexPath.row]
        cell.configure(with: playerRanking, rank: indexPath.row + 1) // 순위 설정
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AssistsRankingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension AssistsRankingViewController {
    
    private func configureTableHeaderView() {
        // 헤더 뷰의 높이와 넓이를 설정
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        // UI 요소들 생성
        let rankLabel = UILabel()
        let playerNameLabel = UILabel()
        let matchesLabel = UILabel()
        let assistsLabel = UILabel()
        
        // 텍스트 설정
        rankLabel.text = "순위"
        playerNameLabel.text = "이름"
        matchesLabel.text = "경기수"
        assistsLabel.text = "도움"
        
        // 폰트 스타일 설정 (선택 사항)
        rankLabel.font = UIFont.boldSystemFont(ofSize: 16)
        playerNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        matchesLabel.font = UIFont.boldSystemFont(ofSize: 16)
        assistsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        // 헤더 뷰에 추가
        headerView.addSubview(rankLabel)
        headerView.addSubview(playerNameLabel)
        headerView.addSubview(matchesLabel)
        headerView.addSubview(assistsLabel)
        
        // 레이아웃 설정
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        matchesLabel.translatesAutoresizingMaskIntoConstraints = false
        assistsLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            assistsLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            assistsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        // 테이블뷰의 tableHeaderView에 설정
        tableView.tableHeaderView = headerView
    }
    
}
