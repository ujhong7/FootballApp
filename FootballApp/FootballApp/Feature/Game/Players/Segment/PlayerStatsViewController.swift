import UIKit

class PlayerStatsViewController: UIViewController {
    
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
    private var playerResponseBySeason: [Int: [PlayerResponse]] = [:] // 시즌별 데이터 저장
    private let loadingIndicatorView = LoadingIndicatorView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    weak var scrollDelegate: ScrollDelegate?
    
    private let recentSeasons = [2024, 2023, 2022, 2021, 2020] // 최근 5개 시즌
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureTableView()
        setupTableViewConstraints()
        fetchPlayerStats()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerStatsTableViewCell.self, forCellReuseIdentifier: PlayerStatsTableViewCell.identifier)
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
    
    private func fetchPlayerStats() {
        loadingIndicatorView.show(in: view)
        
        // 최근 5개 시즌 데이터를 비동기 요청
        let dispatchGroup = DispatchGroup()
        
        for season in recentSeasons {
            dispatchGroup.enter()
            if let playerID = playerID {
                footballService.getPlayerProfile(playerID: playerID, season: String(season), league: premierLeague) {
                    [weak self] result in
                    defer { dispatchGroup.leave() }
                    DispatchQueue.main.async {
                        self?.loadingIndicatorView.hide()
                    }
                    switch result {
                    case .success(let response):
                        self?.playerResponseBySeason[season] = response.response
                    case .failure(let error):
                        print("Error fetching team rankings for season \(season): \(error.localizedDescription)")
                    }
                }
            }
        }
        
        // 모든 데이터가 로드되면 테이블뷰 리로드
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData() // 데이터가 로드된 후 리로드
        }
    }
}

// MARK: - UITableViewDataSource

extension PlayerStatsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // 데이터가 로드되었을 때만 섹션 수를 반환
        return playerResponseBySeason.isEmpty ? 0 : recentSeasons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let season = recentSeasons[section]
        return playerResponseBySeason[season]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerStatsTableViewCell.identifier, for: indexPath) as! PlayerStatsTableViewCell
        let season = recentSeasons[indexPath.section]
        if let playerResponse = playerResponseBySeason[season]?[indexPath.row] {
            cell.configure(with: playerResponse)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 섹션 제목은 해당 시즌에 데이터가 있을 때만 표시
        let season = recentSeasons[section]
        return playerResponseBySeason[season]?.isEmpty ?? true ? nil : "\(season) 시즌"
    }
}

// MARK: - UITableViewDelegate

extension PlayerStatsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(yOffset: scrollView.contentOffset.y)
    }
}
