//
//  HeadToHeadViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/24/24.
//

import UIKit

class HeadToHeadViewController: UIViewController {
    
    // MARK: - init
    
    init(homeTeamID: Int?, awayTeamID: Int?) {
        self.hometeamID = homeTeamID
        self.awayteamID = awayTeamID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private let hometeamID: Int?
    private let awayteamID: Int?
    private let footballService = FootballNetworkService()
    private var fixtures: [Fixture] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    weak var scrollDelegate: ScrollDelegate?
    private let tableView = UITableView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureTableView()
        setupTableViewConstraints()
        fetchHeadToHead()
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
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.identifier)
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
    
    private func fetchHeadToHead() {
        loadingIndicatorView.show(in: view)
        
        if let hometeamID = hometeamID, let awayteamID = awayteamID {
            print("Home Team ID: \(hometeamID), Away Team ID: \(awayteamID)")
            footballService.getHeadToHeadFixtures(team1ID: hometeamID, team2ID: awayteamID) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.hide()
                }
                switch result {
                case .success(let response):
                    print("👽👽👽👽👽👽👽👽👽👽")
                    // ⭐️ 날짜 기준으로 정렬하여 fixtures에 할당 ⭐️
                    let dateFormatter = ISO8601DateFormatter() // ISO 8601 형식에 맞는 날짜 포맷터
                    self?.fixtures = response.response.sorted { fixture1, fixture2 in
                        guard let date1 = dateFormatter.date(from: fixture1.fixture.date),
                              let date2 = dateFormatter.date(from: fixture2.fixture.date) else {
                            return false
                        }
                        return date1 > date2 // 최근 날짜가 위로 오도록 정렬
                    }
                    
                    // 정렬된 데이터 출력
                    //                    for fixture in self?.fixtures ?? [] {
                    //                        if let date = dateFormatter.date(from: fixture.fixture.date) {
                    //                            print("Fixture Date: \(dateFormatter.string(from: date)), Home Team: \(fixture.teams.home.name), Away Team: \(fixture.teams.away.name)")
                    //                        }
                    //                    }
                    for fixture in self?.fixtures ?? [] {
                        if let date = dateFormatter.date(from: fixture.fixture.date),
                           let homeTeam = fixture.teams?.home?.name,
                           let awayTeam = fixture.teams?.away?.name {
                            print("Fixture Date: \(dateFormatter.string(from: date)), Home Team: \(homeTeam), Away Team: \(awayTeam)")
                        } else {
                            print("팀 정보 또는 날짜가 존재하지 않습니다.")
                        }
                    }
                    
                    
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

extension HeadToHeadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFixture = fixtures[indexPath.row]
        let matchInformationVC = MatchResultInformationViewController(fixture: selectedFixture)
        navigationController?.pushViewController(matchInformationVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension HeadToHeadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
        let fixture = fixtures[indexPath.row]
        cell.configure(with: fixture)
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension HeadToHeadViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(yOffset: scrollView.contentOffset.y)
    }
}
