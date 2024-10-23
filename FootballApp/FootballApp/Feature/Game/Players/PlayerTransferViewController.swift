//
//  PlayerTransferViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/22/24.
//

import UIKit

class PlayerTransferViewController: UIViewController {
    
    // MARK: - init
    
    init(playerID: Int?) {
        self.playerID = playerID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private let playerID: Int?
    private let footballService = FootballNetworkService()
    private var transfer: [Transfer] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    private let tableView = UITableView()
    weak var scrollDelegate: ScrollDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureTableView()
        setupTableViewConstraints()
        fetchTransferInformation()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerTransferTableViewCell.self, forCellReuseIdentifier: PlayerTransferTableViewCell.identifier)
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
    
    private func fetchTransferInformation() {
        loadingIndicatorView.show(in: view)
        if let playerID = playerID {
            footballService.getPlayerTransfers(playerID: playerID) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.hide()
                }
                switch result {
                case .success(let response):
                    print("😤😤😤😤😤😤😤😤😤😤")
                    dump(response)
                    self?.transfer = response.response.first?.transfers ?? []
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

extension PlayerTransferViewController: UITableViewDelegate {
    
}

extension PlayerTransferViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transfer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTransferTableViewCell.identifier, for: indexPath) as! PlayerTransferTableViewCell
        let transfer = transfer[indexPath.row]
        cell.configure(with: transfer)
        return cell

    }
}

extension PlayerTransferViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(yOffset: scrollView.contentOffset.y)
    }
}

