//
//  SquadViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/28/24.
//

import UIKit

class SquadViewController: UIViewController {
    
    // MARK: - init
    
    init(fixtureID: Int?) {
        self.fixtureID = fixtureID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private let fixtureID: Int?
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
        fetchfixtureInformation()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SquadTableViewCell.self, forCellReuseIdentifier: SquadTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
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
    
    private func fetchfixtureInformation() {
        loadingIndicatorView.show(in: view)
        
        if let fixtureID = fixtureID {
            footballService.getFixtureInformation(fixtureID: fixtureID) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.hide()
                }
                switch result {
                case .success(let response):
                    print("🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬")
                    dump(response)
                    self?.fixtures = response.response
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
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
    }
    
}

// MARK: - UITableViewDelegate

extension SquadViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension SquadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SquadTableViewCell.identifier, for: indexPath) as! SquadTableViewCell
        let fixture = fixtures[indexPath.row]
        cell.configure(with: fixture)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension SquadViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(yOffset: scrollView.contentOffset.y)
    }
}
