//
//  MatchResultViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

final class MatchResultViewController: UIViewController {
    
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
                if let networkError = error as? NetworkError {
                    switch networkError {
                    case .invalidURL:
                        print("유효하지 않은 URL입니다.")
                    case .noData:
                        print("데이터가 없습니다.")
                    case .decodingError:
                        print("데이터 디코딩 실패.")
                    case .httpError(let statusCode):
                        print("HTTP 오류 발생: 상태 코드 \(statusCode)")
                    case .unknownError:
                        print("알 수 없는 오류 발생.")
                    }
                } else {
                    print("기타 오류 발생: \(error.localizedDescription)")
                }
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

extension MatchResultViewController: UITableViewDataSource {
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

extension MatchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFixture = filteredFixtures[indexPath.row]
        let matchInformationVC = MatchResultInformationViewController(fixture: selectedFixture)
        navigationController?.pushViewController(matchInformationVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension MatchResultViewController: UICollectionViewDataSource {
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
        cell.changeSelectedColor(isSelected: indexPath == selectedTabIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MatchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let totalCount = collectionView.numberOfItems(inSection: indexPath.section)
        let index = totalCount - indexPath.row
        filterFixturesByRound(roundNumber: index)
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
