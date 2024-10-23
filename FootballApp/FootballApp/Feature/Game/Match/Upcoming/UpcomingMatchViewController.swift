//
//  UpcomingMatchViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class UpcomingMatchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    private let roundTabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let footballService = FootballNetworkService()
    private var upcomingFixtures: [Fixture] = []
    private var filteredFixtures: [Fixture] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    private var selectedTabIndex: IndexPath = IndexPath(row: 0, section: 0)
    private var currentRound: Int = 0  // ★ 수정: 현재 진행된 라운드를 저장하는 프로퍼티
    private var maxRound: Int = 0  // ★ 수정: 최대 라운드를 저장하는 프로퍼티
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configureTableView()
        configureCollectionView()
        setupTableViewHeaderView()
        fetchUpcomingFixtures()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = 58 // 🚨
        tableView.isScrollEnabled = false
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
        roundTabCollectionView.backgroundColor = .systemBackground
        roundTabCollectionView.allowsMultipleSelection = false
        roundTabCollectionView.showsHorizontalScrollIndicator = false
        roundTabCollectionView.delegate = self
        roundTabCollectionView.dataSource = self
        roundTabCollectionView.register(RoundTabCollectionViewCell.self, forCellWithReuseIdentifier: RoundTabCollectionViewCell.identifier)
        roundTabCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableViewHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        headerView.addSubview(roundTabCollectionView)
        headerView.addSubview(separatorLine)
        NSLayoutConstraint.activate([
            roundTabCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            roundTabCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            roundTabCollectionView.topAnchor.constraint(equalTo: headerView.topAnchor),
            roundTabCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            separatorLine.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        tableView.tableHeaderView = headerView
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
                self?.filteredFixtures = self?.upcomingFixtures ?? []
                
                // 현재 라운드 및 최대 라운드 설정
                if let max = response.response.compactMap({ Int($0.league.round.filter { $0.isNumber }) }).max() {
                    self?.maxRound = max
                }
                if let current = response.response.compactMap({ Int($0.league.round.filter { $0.isNumber }) }).min() {
                    self?.currentRound = current - 1
                }
                
                DispatchQueue.main.async {
                    self?.setupRoundTabCollectionView()
                }
            case .failure(let error):
                print("Error fetching upcoming fixtures: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupRoundTabCollectionView() {
        self.roundTabCollectionView.reloadData()
        DispatchQueue.main.async {
            self.collectionView(self.roundTabCollectionView, didSelectItemAt: self.selectedTabIndex)
        }
    }
    
    private func filterFixturesByRound(roundNumber: Int) {
        filteredFixtures = upcomingFixtures.filter {
            // 라운드 문자열에서 숫자만 추출하여 정확하게 일치하는지 확인
            if let fixtureRound = Int($0.league.round.filter { $0.isNumber }) {
                return fixtureRound == roundNumber
            }
            return false
        }
        print("🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨")
        dump(filteredFixtures)
        self.tableView.reloadData()
    }
    
    
}

// MARK: - UITableViewDataSource

extension UpcomingMatchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
        let fixture = filteredFixtures[indexPath.row]
        cell.configure(with: fixture)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UpcomingMatchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFixture = filteredFixtures[indexPath.row]
        let matchInformationVC = UpcomingMatchInformationViewController(fixture: selectedFixture)
        navigationController?.pushViewController(matchInformationVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension UpcomingMatchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxRound - currentRound
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = roundTabCollectionView.dequeueReusableCell(withReuseIdentifier: RoundTabCollectionViewCell.identifier, for: indexPath) as? RoundTabCollectionViewCell else { return UICollectionViewCell() }
        // ★ 수정: 현재 라운드부터 순차적으로 탭에 표시
        let round = currentRound + indexPath.row + 1
        cell.configure(round: round)
        cell.changeSelectedColor(isSelected: indexPath == selectedTabIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension UpcomingMatchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roundNumber = currentRound + indexPath.row + 1 // 선택된 라운드 번호
        filterFixturesByRound(roundNumber: roundNumber) // 선택된 라운드에 맞춰 필터링
        
        if let previousCell = collectionView.cellForItem(at: selectedTabIndex) as? RoundTabCollectionViewCell {
            previousCell.changeSelectedColor(isSelected: false)
        }
        selectedTabIndex = indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? RoundTabCollectionViewCell {
            cell.changeSelectedColor(isSelected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? RoundTabCollectionViewCell {
            cell.changeSelectedColor(isSelected: false)
        }
    }
}
