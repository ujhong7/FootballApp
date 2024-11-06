//
//  AssistsPlayerViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class AssistsPlayerViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let footballService = FootballNetworkService()
    private var assistRankings: [PlayerRanking] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        configureTableView()
        configureTableHeaderView()
        fetchTopAssists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 선택된 셀이 있을 경우 선택 해제
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
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
    
    private func fetchTopAssists() {
        loadingIndicatorView.show(in: view)
        
        footballService.getTopAssists(league: premierLeague, season: season2024) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.loadingIndicatorView.hide()
            }
            
            switch result {
            case .success(let response):
                print("🐶🐶🐶🐶🐶")
                dump(response)
                self?.assistRankings = response.response
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching top assists: \(error.localizedDescription)")
            }
        }
    }
    
    
}

// MARK: - UITableViewDataSource

extension AssistsPlayerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assistRankings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AssistsRankingTableViewCell.identifier, for: indexPath) as? AssistsRankingTableViewCell else {
            return UITableViewCell()
        }
        
        let playerRanking = assistRankings[indexPath.row]
        cell.configure(with: playerRanking, rank: indexPath.row + 1)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AssistsPlayerViewController: UITableViewDelegate {
    // 🚨
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlayer = assistRankings[indexPath.row]
        let assistPlayerInformationVC = PlayerInformationViewController(playerRanking: selectedPlayer)
        navigationController?.pushViewController(assistPlayerInformationVC, animated: true)
    }
}

// MARK: - configureTableHeaderView

extension AssistsPlayerViewController {
    
    private func configureTableHeaderView() {
        // 헤더 뷰의 높이와 넓이를 설정
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .systemBackground
        
        // separatorLine 추가
        headerView.addSubview(separatorLine)
        
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
            assistsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // separatorLine 레이아웃 설정
            separatorLine.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        // 테이블뷰의 tableHeaderView에 설정
        tableView.tableHeaderView = headerView
    }
    
}
