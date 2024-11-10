//
//  TeamSquadViewController.swift
//  FootballApp
//
//  Created by yujaehong on 11/1/24.
//

import UIKit

class TeamSquadViewController: UIViewController {
    
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
    private var players: [Player] = []
    private var goalkeepers: [Player] = []
    private var defenders: [Player] = []
    private var midfielders: [Player] = []
    private var forwards: [Player] = []
    private var coachs: [CoachInfo] = []
    private let loadingIndicatorView = LoadingIndicatorView()
    weak var scrollDelegate: ScrollDelegate?
    private let tableView =  UITableView(frame: .zero, style: .grouped)
    private var isDataLoaded = false // 데이터를 로드했는지 여부를 확인하는 플래그
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureTableView()
        setupTableViewConstraints()
        fetchTeamSqaud()
        fetchTeamCoaches()
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
        tableView.register(TeamSquadTableViewCell.self, forCellReuseIdentifier: TeamSquadTableViewCell.identifier)
        tableView.register(TeamCoachTableViewCell.self, forCellReuseIdentifier: TeamCoachTableViewCell.identifier)
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
    
    private func fetchTeamSqaud() {
        loadingIndicatorView.show(in: view)
        if let teamID = teamID {
            footballService.getTeamSquad(teamID: teamID) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.hide()
                }
                switch result {
                case .success(let response):
                    print("🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃🎃")
                    dump(response)
                    self?.players = response.response.flatMap { $0.players }
                    self?.goalkeepers = self?.players.filter { $0.position == "Goalkeeper" } ?? []
                    self?.defenders = self?.players.filter { $0.position == "Defender" } ?? []
                    self?.midfielders = self?.players.filter { $0.position == "Midfielder" } ?? []
                    self?.forwards = self?.players.filter { $0.position == "Attacker" } ?? []
                    self?.isDataLoaded = true
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching team rankings: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchTeamCoaches() {
        if let teamID = teamID {
            footballService.getTeamCoachs(teamID: teamID) { [weak self] result in
                switch result {
                case .success(let response):
                    print("👁️👁️👁️👁️👁️👁️👁️👁️👁️👁️")
                    dump(response)
                    self?.coachs = response.response
                    self?.isDataLoaded = true
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

extension TeamSquadViewController: UITableViewDelegate {
    // 데이터 모델 수정해서 사용하기!!!
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//           let selectedPlayer: Player3
//           
//           // 선택된 섹션에 따라 올바른 선수 목록에서 데이터를 가져옵니다.
//           switch indexPath.section {
//           case 1:
//               selectedPlayer = goalkeepers[indexPath.row]
//           case 2:
//               selectedPlayer = defenders[indexPath.row]
//           case 3:
//               selectedPlayer = midfielders[indexPath.row]
//           case 4:
//               selectedPlayer = forwards[indexPath.row]
//           default:
//               return // 코치 섹션일 경우 아무 동작도 하지 않음
//           }
//           
//           // PlayerInformationViewController로 화면 전환
//           let playerInfoVC = PlayerInformationViewController(player: selectedPlayer)
//           navigationController?.pushViewController(playerInfoVC, animated: true)
//       }
}

// MARK: - UITableViewDataSource

extension TeamSquadViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isDataLoaded ? 5 : 0 // 데이터가 로드되기 전까지 섹션 수를 0으로 설정
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isDataLoaded else { return 0 }
        switch section {
        case 0:
            return coachs.count
        case 1:
            return goalkeepers.count
        case 2:
            return defenders.count
        case 3:
            return midfielders.count
        case 4:
            return forwards.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 코치 섹션
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamCoachTableViewCell.identifier, for: indexPath) as! TeamCoachTableViewCell
            let coach = coachs[indexPath.row]
            cell.configure(with: coach)
            return cell
        } else {
            // 선수 섹션
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamSquadTableViewCell.identifier, for: indexPath) as! TeamSquadTableViewCell
            let player: Player
            
            switch indexPath.section {
            case 1:
                player = goalkeepers[indexPath.row]
            case 2:
                player = defenders[indexPath.row]
            case 3:
                player = midfielders[indexPath.row]
            case 4:
                player = forwards[indexPath.row]
            default:
                fatalError("Invalid section")
            }
            
            cell.configure(with: player)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard isDataLoaded else { return nil } // 데이터가 로드되기 전까지 섹션 헤더를 nil로 설정
        switch section {
        case 0: return "Coaches"
        case 1: return "Goalkeepers"
        case 2: return "Defenders"
        case 3: return "Midfielders"
        case 4: return "Forwards"
        default: return nil
        }
    }
    
}

// MARK: - UIScrollViewDelegate

extension TeamSquadViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(yOffset: scrollView.contentOffset.y)
    }
}
