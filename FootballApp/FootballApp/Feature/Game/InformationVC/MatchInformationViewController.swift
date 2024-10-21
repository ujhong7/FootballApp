////
////  MatchInformationViewController.swift
////  FootballApp
////
////  Created by yujaehong on 10/15/24.
////
//
//import UIKit
//
//class MatchInformationViewController: UIViewController {
//    
//    // MARK: - Properties
//    
//    var fixture: Fixture?  // 전달받은 경기 정보
//    
//    // 커스텀 이니셜라이저로 Fixture 데이터 전달
//    init(fixture: Fixture?) {
//        self.fixture = fixture
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    private let headerView: UIView = {
//        let view = UIView()
//        return view
//    }()
//    
//    private let homeTeamNameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 13)
//        label.textAlignment = .center
//        label.numberOfLines = 2
//        return label
//    }()
//    
//    private let awayTeamNameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 13)
//        label.textAlignment = .center
//        label.numberOfLines = 2
//        return label
//    }()
//    
//    private let homeTeamLogoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//    
//    private let awayTeamLogoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//    
//    private let homeTeamGoalsLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 40)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let awayTeamGoalsLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 40)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let statusLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 40)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 40)
//        label.textAlignment = .center
//        return label
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
//        setDataMatchInformation()
//        setupNavigationBar()
//        setupBackgroundColor()
//        setupHeaderView()
//        configureCollectionView()
//        configureTableView()
//        setupObservers()
//    }
//    
//    deinit {
//        tableView.removeObserver(self, forKeyPath: "contentOffset")
//    }
//    
//    // MARK: - Methods
//    
//    private func setupBackgroundColor() {
//        view.backgroundColor = .footballFieldGreen
//        headerView.backgroundColor = .footballFieldGreen
//        menuTabCollectionView.backgroundColor = .footballFieldGreen
//    }
//    
//    private func setupNavigationBar() {
//        navigationController?.navigationBar.tintColor = UIColor.white // 버튼 색상
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] // 타이틀 색상
//    }
//    
//    private func setDataMatchInformation() {
//        // 🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨
//        // 전달된 fixture를 사용하여 UI 업데이트
//        if let fixture = fixture {
//            print("Fixture info: \(fixture)")
//            // UI에 경기 정보 표시하는 코드 추가
//            let homeTeam = fixture.teams.home
//            let awayTeam = fixture.teams.away
//            let homeGoals = fixture.goals.home
//            let awayGoals = fixture.goals.away
//            let status = fixture.fixture.status.long
//            let date = fixture.fixture.date
//            
//            homeTeamNameLabel.text = homeTeam.name
//            homeTeamLogoImageView.loadImage(from: homeTeam.logo)
//            awayTeamNameLabel.text = awayTeam.name
//            awayTeamLogoImageView.loadImage(from: awayTeam.logo)
//            homeTeamGoalsLabel.text = "\(homeGoals ?? 0)"
//            awayTeamGoalsLabel.text = "\(awayGoals ?? 0)"
//            navigationItem.title = "\(teamAbbreviations[homeTeam.name] ?? homeTeam.name)     \(homeGoals ?? 0)   -   \(awayGoals ?? 0)     \(teamAbbreviations[awayTeam.name] ?? awayTeam.name)"
//        }
//    }
//    
//    private func setupHeaderView() {
//        view.addSubview(headerView)
//        headerView.addSubview(homeTeamNameLabel)
//        headerView.addSubview(awayTeamNameLabel)
//        headerView.addSubview(homeTeamLogoImageView)
//        headerView.addSubview(awayTeamLogoImageView)
//        headerView.addSubview(homeTeamGoalsLabel)
//        headerView.addSubview(awayTeamGoalsLabel)
//        headerView.addSubview(statusLabel)
//        headerView.addSubview(dateLabel)
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        homeTeamNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        awayTeamNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        homeTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
//        awayTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
//        homeTeamGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
//        awayTeamGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
//        statusLabel.translatesAutoresizingMaskIntoConstraints = false
//        dateLabel.translatesAutoresizingMaskIntoConstraints = false
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
//            homeTeamGoalsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -10),
//            homeTeamGoalsLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: -40),
//            awayTeamGoalsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -10),
//            awayTeamGoalsLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 40),
//            homeTeamLogoImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 40),
//            homeTeamLogoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -20),
//            awayTeamLogoImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -40),
//            awayTeamLogoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -20),
//            homeTeamLogoImageView.widthAnchor.constraint(equalToConstant: 45),
//            homeTeamLogoImageView.heightAnchor.constraint(equalToConstant: 45),
//            awayTeamLogoImageView.widthAnchor.constraint(equalToConstant: 45),
//            awayTeamLogoImageView.heightAnchor.constraint(equalToConstant: 45),
//            homeTeamNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
//            homeTeamNameLabel.topAnchor.constraint(equalTo: homeTeamLogoImageView.bottomAnchor, constant: 10),
//            awayTeamNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
//            awayTeamNameLabel.topAnchor.constraint(equalTo: awayTeamLogoImageView.bottomAnchor, constant: 10),
//            homeTeamNameLabel.widthAnchor.constraint(equalToConstant: 100),
//            awayTeamNameLabel.widthAnchor.constraint(equalToConstant: 100),
//        ])
//    }
//    
//    private func configureTableView() {
//        tableView.backgroundColor = .systemBackground
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(ExTableViewCell.self, forCellReuseIdentifier: ExTableViewCell.identifier)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView)
//        setupTableViewConstraints()
//    }
//    
//    private func setupTableViewConstraints() {
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: menuTabCollectionView.bottomAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
//        ])
//    }
//    
//    private func configureCollectionView() {
//        menuTabCollectionView.allowsMultipleSelection = false
//        menuTabCollectionView.showsHorizontalScrollIndicator = false
//        menuTabCollectionView.delegate = self
//        menuTabCollectionView.dataSource = self
//        menuTabCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        menuTabCollectionView.register(ExCollectionViewCell.self, forCellWithReuseIdentifier: ExCollectionViewCell.identifier)
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
//}
//
//// MARK: - UITableViewDelegate
//
//extension MatchInformationViewController: UITableViewDelegate {
//    
//}
//
//// MARK: - UITableViewDataSource
//
//extension MatchInformationViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 30
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExTableViewCell.identifier, for: indexPath) as? ExTableViewCell else { return UITableViewCell() }
//        cell.backgroundColor = .systemBackground
//        return cell
//    }
//    
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension MatchInformationViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = menuTabCollectionView.dequeueReusableCell(withReuseIdentifier: ExCollectionViewCell.identifier, for: indexPath) as? ExCollectionViewCell else { return UICollectionViewCell() }
//        return cell
//    }
//    
//    
//}
//
//// MARK: - UICollectionViewDelegate
//
//extension MatchInformationViewController: UICollectionViewDelegate {
//    
//    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    //        guard let cell = menuTabCollectionView.cellForItem(at: indexPath) as? ExCollectionViewCell else { return }
//    //                cell.updateSelectionState() // 선택된 셀 상태 업데이트
//    //    }
//    //
//    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//    //        guard let cell = menuTabCollectionView.cellForItem(at: indexPath) as? ExCollectionViewCell else { return }
//    //        cell.updateSelectionState() // 선택 해제된 셀 상태 업데이트
//    //    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//
//extension MatchInformationViewController: UICollectionViewDelegateFlowLayout {
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
//extension MatchInformationViewController: UIScrollViewDelegate {
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
//extension MatchInformationViewController {
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "contentOffset" {
//            guard let tableView = object as? UITableView else { return }
//            let offset = tableView.contentOffset.y
//            
//            // 헤더 뷰의 높이 조정
//            if offset < 0 {
//                headerViewHeightConstraint.constant = 100 - offset // 스크롤이 위로 올라갈 때 헤더 뷰 높이 증가
//            } else {
//                headerViewHeightConstraint.constant = max(0, 100 - offset) // 헤더 뷰 높이 감소
//            }
//            
//            // 헤더 뷰의 알파 값 조정 (투명도)
//            let alpha = max(0, min(1, 1 - (offset / 100))) // 최대 100 포인트 스크롤 시 완전히 투명해짐
//            headerView.alpha = alpha
//            
//            // 타이틀 텍스트의 알파 값 조정
//            let titleAlpha = max(0, min(1, (offset - 60) / 40))
//            navigationController?.navigationBar.titleTextAttributes = [
//                .foregroundColor: UIColor.white.withAlphaComponent(titleAlpha)
//            ]
//            
//            // 컬렉션 뷰를 화면 상단에 고정
//            if offset > 99 { // 60 포인트 이상 스크롤 시
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.headerViewHeightConstraint.constant = 0 // 헤더 뷰 숨기기
//                    self.menuTabCollectionView.transform = CGAffineTransform(translationX: 0, y: -self.headerViewHeightConstraint.constant) // 컬렉션 뷰 고정
//                    self.view.layoutIfNeeded() // 레이아웃 업데이트
//                })
//            } else {
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.menuTabCollectionView.transform = .identity // 원래 위치로 되돌리기
//                    self.view.layoutIfNeeded() // 레이아웃 업데이트
//                })
//            }
//        }
//    }
//    
//    private func setupObservers() {
//        // 테이블 뷰의 스크롤 위치를 감지하는 이벤트 설정
//        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
//    }
//    
//}
