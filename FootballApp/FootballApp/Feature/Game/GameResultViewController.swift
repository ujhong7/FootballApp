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
    private var filteredFixtures: [Fixture] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    private var selectedTabIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        configureTableView()
        configureCollectionView()
        setupTableViewHeaderView()
        fetchPastFixtures()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .premierLeagueBackgroundColor
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
        roundTabCollectionView.backgroundColor = .premierLeagueBackgroundColor
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
        NSLayoutConstraint.activate([
            roundTabCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            roundTabCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            roundTabCollectionView.topAnchor.constraint(equalTo: headerView.topAnchor),
            roundTabCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
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
                dump(response)
                self?.fixtures = response.response.reversed()
                self?.filteredFixtures = self?.fixtures ?? []
                DispatchQueue.main.async {
                    self?.setupRoundTabCollectionView()
                }
            case .failure(let error):
                print("Error fetching fixtures: \(error.localizedDescription)")
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
        filteredFixtures = fixtures.filter { $0.league.round.contains(String(roundNumber)) }
        self.tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

extension GameResultViewController: UITableViewDataSource {
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

extension GameResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 fixture를 가져옴
        let selectedFixture = filteredFixtures[indexPath.row]
        // MatchInformationViewController에 fixture 데이터를 전달
        let matchInformationVC = MatchInformationViewController(fixture: selectedFixture)
        navigationController?.pushViewController(matchInformationVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension GameResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let maxRound = fixtures.compactMap({ Int(($0.league.round.filter { $0.isNumber }))}).max() else {
            return 0
        }
        return maxRound
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = roundTabCollectionView.dequeueReusableCell(withReuseIdentifier: RoundTabCollectionViewCell.identifier, for: indexPath) as? RoundTabCollectionViewCell else { return UICollectionViewCell() }
        let totalCount = collectionView.numberOfItems(inSection: indexPath.section)
        let reverseIndex = totalCount - indexPath.row
        cell.configure(round: reverseIndex)
        cell.changeBackgroundColor(isSelected: indexPath == selectedTabIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GameResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let totalCount = collectionView.numberOfItems(inSection: indexPath.section)
        let index = totalCount - indexPath.row
        filterFixturesByRound(roundNumber: index)
        if let previousCell = collectionView.cellForItem(at: selectedTabIndex) as? RoundTabCollectionViewCell {
            previousCell.changeBackgroundColor(isSelected: false)
        }
        selectedTabIndex = indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? RoundTabCollectionViewCell {
            cell.changeBackgroundColor(isSelected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? RoundTabCollectionViewCell {
            cell.changeBackgroundColor(isSelected: false)
        }
    }
}
