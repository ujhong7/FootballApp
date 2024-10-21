////
////  TeamInformationViewController.swift
////  FootballApp
////
////  Created by yujaehong on 10/15/24.
////
//
//import UIKit
//
//enum MenuOption: String, CaseIterable {
//    case matches = "경기"
//    case playerInformation = "선수 정보"
//    case teamStatistics = "팀 통계"
//    case teamInformation = "팀 정보"
//    case transferInformation = "이적 정보"
//}
//
//class TeamInformationViewController: UIViewController {
//    
//    // MARK: - Properties
//    
//    var teamInfo: TeamInformation?
//    
//    private var selectedMenuOption: MenuOption = .matches // 기본 메뉴 옵션
//    private var tableViewData: [Any] = [] // 테이블 뷰에 표시할 데이터 배열
//    
//    private let footballService = FootballNetworkService()
//    private var fixtures: [Fixture] = []
//    private var teamDetails: [TeamDetail] = []
//    
//    init(teamInfo: TeamInformation?) {
//        self.teamInfo = teamInfo
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    private let headerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBlue
//        return view
//    }()
//    
//    private let teamNameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 24)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let teamLogoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//    
//    private let tableView = UITableView()
//    
//    private let menuTabCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//    
//    private var headerViewHeightConstraint: NSLayoutConstraint!
//    
//    // MARK: - LifeCycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        setupHeaderView()
//        configureCollectionView()
//        configureTableView()
//        setupObservers()
//        setDataTeamInformation()
//    }
//    
//    deinit {
//        tableView.removeObserver(self, forKeyPath: "contentOffset")
//    }
//    
//    // MARK: - Methods
//    
//    private func setDataTeamInformation() {
//        print("⚽️ 팀이름: \(teamInfo?.name)")
//        print("⚽️ 팀ID: \(teamInfo?.id)")
//        teamLogoImageView.loadImage(from: teamInfo?.logo ?? "")
//        if let teamName = teamInfo?.name {
//            //titleView.text = teamName
//            navigationItem.title = teamName
//            teamNameLabel.text = teamName
//            // 색
//            headerView.backgroundColor = TeamColors.color(for: teamName)
//            view.backgroundColor = TeamColors.color(for: teamName)
//            menuTabCollectionView.backgroundColor = TeamColors.color(for: teamName)
//        }
//    }
//    
//    private func setupNavigationBar() {
//        navigationController?.navigationBar.tintColor = UIColor.white // 버튼 색상
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] // 타이틀 색상
//    }
//    
//    private func setupHeaderView() {
//        view.addSubview(headerView)
//        headerView.addSubview(teamLogoImageView)
//        headerView.addSubview(teamNameLabel)
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
//        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100) // 초기 헤더 높이 설정
//        headerViewHeightConstraint.isActive = true
//        setupHeaderViewConstraints()
//    }
//    
//    private func setupHeaderViewConstraints() {
//        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            teamLogoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            teamLogoImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
//            teamLogoImageView.widthAnchor.constraint(equalToConstant: 80),
//            teamLogoImageView.heightAnchor.constraint(equalToConstant: 80),
//            teamNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            teamNameLabel.leadingAnchor.constraint(equalTo: teamLogoImageView.trailingAnchor, constant: 15),
//        ])
//    }
//    
//    private func configureTableView() {
//        tableView.backgroundColor = .systemBackground
//        tableView.delegate = self
//        tableView.dataSource = self
//        //        tableView.register(ExTableViewCell.self, forCellReuseIdentifier: ExTableViewCell.identifier)
//        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.identifier) // 🟨
//        tableView.register(TeamInformationTableViewCell.self, forCellReuseIdentifier: TeamInformationTableViewCell.identifier) // 🟦
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView)
//        setupTableViewConstraints()
//    }
//    
//    private func setupTableViewConstraints() {
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: menuTabCollectionView.bottomAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//    
//    private func configureCollectionView() {
//        menuTabCollectionView.allowsMultipleSelection = false
//        menuTabCollectionView.showsHorizontalScrollIndicator = false
//        menuTabCollectionView.delegate = self
//        menuTabCollectionView.dataSource = self
//        menuTabCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        menuTabCollectionView.register(CategoryTabTableViewCell.self, forCellWithReuseIdentifier: CategoryTabTableViewCell.identifier)
//        menuTabCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
//        view.addSubview(menuTabCollectionView)
//        setupCollectionViewConstraints()
//    }
//    
//    private func setupCollectionViewConstraints() {
//        NSLayoutConstraint.activate([
//            menuTabCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
//            menuTabCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            menuTabCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            menuTabCollectionView.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
//    
//    // 테이블뷰 업데이트 메서드
//    private func updateTableView(for menuOption: MenuOption) {
//        selectedMenuOption = menuOption
//        switch menuOption {
//        case .matches:
//            fetchLast5Matches()
//            break
//        case .playerInformation:
//            
//            break
//        case .teamStatistics:
//            
//            break
//        case .teamInformation:
//            fetchTeamInformation()
//            break
//        case .transferInformation:
//            
//            break
//        }
//    }
//    
//}
//
//// MARK: - Fetch
//
//extension TeamInformationViewController {
//    
//    private func fetchLast5Matches() {
//        if let teamId = teamInfo?.id {
//            footballService.getLastFiveFixtures(teamID: teamId, league: premierLeague, season: season2024) { [weak self] result in
//                switch result {
//                case .success(let response):
//                    print("🟨🟨🟨🟨🟨🟨🟨🟨")
//                    dump(response)
//                    self?.fixtures = response.response
//                    self?.tableViewData = self?.fixtures as? [Any] ?? [] // 데이터 소스 업데이트
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData() // 메인 스레드에서 UI 업데이트
//                    }
//                case .failure(let error):
//                    print("Error fetching fixtures: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//    
//    private func fetchTeamInformation() {
//        if let teamId = teamInfo?.id {
//            footballService.getTeamInfo(teamID: teamId) { [weak self] result in
//                switch result {
//                case .success(let response):
//                    print("🟦🟦🟦🟦🟦🟦🟦🟦")
//                    dump(response)
//                    self?.teamDetails = response.response
//                    self?.tableViewData = self?.teamDetails as? [Any] ?? [] // 데이터 소스 업데이트
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData() // 메인 스레드에서 UI 업데이트
//                    }
//                case .failure(let error):
//                    print("Error fetching fixtures: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//    
//}
//
//// MARK: - UITableViewDelegate
//
//extension TeamInformationViewController: UITableViewDelegate {
//    
//}
//
//// MARK: - UITableViewDataSource
//
//extension TeamInformationViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableViewData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if selectedMenuOption == .matches {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as? MatchTableViewCell else { return UITableViewCell() }
//            let fixture = tableViewData[indexPath.row] as! Fixture // data source에서 가져오기
//            cell.configure(with: fixture)
//            return cell
//        } else if selectedMenuOption == .playerInformation {
//            
//        } else if selectedMenuOption == .teamStatistics {
//            
//        } else if selectedMenuOption == .teamInformation {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamInformationTableViewCell.identifier, for: indexPath) as? TeamInformationTableViewCell else { return UITableViewCell() }
//            let teamDetail = tableViewData[indexPath.row] as! TeamDetail // data source에서 가져오기
//            cell.configure(with: teamDetail)
//            return cell
//        } else if selectedMenuOption == .transferInformation {
//            
//        }
//        
//        return UITableViewCell() // 기본값
//    }
//    
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension TeamInformationViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MenuOption.allCases.count // 메뉴 옵션의 수
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = menuTabCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryTabTableViewCell.identifier, for: indexPath) as? CategoryTabTableViewCell else { return UICollectionViewCell() }
//        // 메뉴 제목 설정
//        let menuOption = MenuOption.allCases[indexPath.item]
//        cell.label.text = menuOption.rawValue // cell의 레이블에 메뉴 제목 설정
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // 선택된 메뉴에 따라 테이블 뷰의 내용을 업데이트
//        let selectedMenuOption = MenuOption.allCases[indexPath.item]
//        updateTableView(for: selectedMenuOption)
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//
//extension TeamInformationViewController: UICollectionViewDelegate {
//    
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//
//extension TeamInformationViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0 // 셀 간의 수평 간격을 0으로 설정
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0 // 셀 간의 수직 간격을 0으로 설정
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.bounds.width / 5 // 5개의 셀을 가로로 배치할 경우
//        let height: CGFloat = 40 // 원하는 높이 설정
//        return CGSize(width: width, height: height)
//    }
//    
//}
//
//// MARK: - UIScrollViewDelegate
//
//extension TeamInformationViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == tableView {
//            // 테이블 뷰의 컨텐츠 오프셋을 확인
//            if tableView.contentOffset.y < 0 {
//                // 테이블 뷰의 스크롤을 막음
//                tableView.contentOffset.y = 0
//            }
//        }
//    }
//}
//
//// MARK: - KVO for scrolling
//
//extension TeamInformationViewController {
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        //        if keyPath == "contentOffset" {
//        //            guard let tableView = object as? UITableView else { return }
//        //            let offset = tableView.contentOffset.y
//        //
//        //            // 헤더 뷰의 높이 조정
//        //            if offset < 0 {
//        //                headerViewHeightConstraint.constant = 100 - offset // 스크롤이 위로 올라갈 때 헤더 뷰 높이 증가
//        //            } else {
//        //                headerViewHeightConstraint.constant = max(0, 100 - offset) // 헤더 뷰 높이 감소
//        //            }
//        //
//        //            // 헤더 뷰의 알파 값 조정 (투명도)
//        //            let alpha = max(0, min(1, 1 - (offset / 100))) // 최대 100 포인트 스크롤 시 완전히 투명해짐
//        //            headerView.alpha = alpha
//        //
//        //            // 타이틀 텍스트의 알파 값 조정
//        //            let titleAlpha = max(0, min(1, (offset - 60) / 40))
//        //            navigationController?.navigationBar.titleTextAttributes = [
//        //                .foregroundColor: UIColor.white.withAlphaComponent(titleAlpha)
//        //            ]
//        //
//        //            // 컬렉션 뷰를 화면 상단에 고정
//        //            if offset > 99 { // 60 포인트 이상 스크롤 시
//        //                UIView.animate(withDuration: 0.3, animations: {
//        //                    self.headerViewHeightConstraint.constant = 0 // 헤더 뷰 숨기기
//        //                    self.menuTabCollectionView.transform = CGAffineTransform(translationX: 0, y: -self.headerViewHeightConstraint.constant) // 컬렉션 뷰 고정
//        //                    self.view.layoutIfNeeded() // 레이아웃 업데이트
//        //                })
//        //            } else {
//        //                UIView.animate(withDuration: 0.3, animations: {
//        //                    self.menuTabCollectionView.transform = .identity // 원래 위치로 되돌리기
//        //                    self.view.layoutIfNeeded() // 레이아웃 업데이트
//        //                })
//        //            }
//        //        }
//    }
//    
//    private func setupObservers() {
//        // 테이블 뷰의 스크롤 위치를 감지하는 이벤트 설정
//        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
//    }
//    
//}
