//
//  TeamPreviousMatchViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/21/24.
//

import UIKit

class TeamPreviousMatchViewController: UIViewController {

    // MARK: - init
    
    init(teamID: Int?) {
        self.teamID = teamID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private let teamID: Int?
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
        fetchPreviousMatch()
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
    
    private func fetchPreviousMatch() {
        loadingIndicatorView.show(in: view)
        if let teamID = teamID {
            footballService.getTeamPreviousFixtures(teamID: teamID, league: premierLeague, season: season2024) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.hide()
                }
                switch  result {
                case .success(let response):
                    print("🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣")
                    dump(response)
                    self?.fixtures = response.response
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

extension TeamPreviousMatchViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension TeamPreviousMatchViewController: UITableViewDataSource {
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

extension TeamPreviousMatchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(yOffset: scrollView.contentOffset.y)
    }
}
