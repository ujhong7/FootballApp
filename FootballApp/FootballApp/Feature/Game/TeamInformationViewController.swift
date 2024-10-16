//
//  TeamInformationViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/15/24.
//

import UIKit

class TeamInformationViewController: UIViewController {
    
    // MARK: - Properties
    
    var teamInfo: TeamInformation?
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.text = "팀 이름 navi"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.alpha = 0 // 처음에는 보이지 않게 설정
        return label
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "팀 이름"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let teamLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "TOT")
        return imageView
    }()
    
    private let tableView = UITableView()
    private let menuTabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var headerViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("")
//        NavigationBarUtility.setupNavigationBarAppearance(for: navigationController, backgroundColor: .systemBlue)
        view.backgroundColor = .systemBlue
        setupHeaderView()
        configureCollectionView()
        configureTableView()
        setupTitleView() // 🚨
        setupObservers()
        setupTeamInfo()
        print("TitleView Alpha in viewDidLoad: \(titleView.alpha)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TitleView Alpha in viewWillAppear: \(titleView.alpha)")
        titleView.alpha = 0
        print("TitleView Alpha in viewWillAppear: \(titleView.alpha)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("🤮🤮🤮🤮🤮 TitleView Alpha in viewDidAppear: \(titleView.alpha)")
        //        titleView.alpha = 0
        //        print("🚨TitleView Alpha in viewDidAppear: \(titleView.alpha)") // 🚨
    }
    
    deinit {
        tableView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    // MARK: - Methods
    
    private func setupTeamInfo() {
        titleView.text = teamInfo?.name
        teamNameLabel.text = teamInfo?.name
        teamLogoImageView.loadImage(from: teamInfo?.logo ?? "")
    }
    
    // 🚨
    private func setupTitleView() {
        navigationItem.titleView = titleView // 네비게이션 바의 타이틀 뷰로 설정
        navigationItem.titleView?.alpha = 0
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.addSubview(teamLogoImageView)
        headerView.addSubview(teamNameLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100) // 초기 헤더 높이 설정
        headerViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            teamLogoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            teamLogoImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            teamLogoImageView.widthAnchor.constraint(equalToConstant: 80), // 로고 이미지 너비
            teamLogoImageView.heightAnchor.constraint(equalToConstant: 80), // 로고 이미지 높이
            
            teamNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            teamNameLabel.leadingAnchor.constraint(equalTo: teamLogoImageView.trailingAnchor, constant: 15),
        ])
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExTableViewCell.self, forCellReuseIdentifier: ExTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: menuTabCollectionView.bottomAnchor), // 컬렉션 뷰 아래에서 시작
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func configureCollectionView() {
        menuTabCollectionView.backgroundColor = .systemBackground
        menuTabCollectionView.allowsMultipleSelection = false
        menuTabCollectionView.showsHorizontalScrollIndicator = false
        menuTabCollectionView.delegate = self
        menuTabCollectionView.dataSource = self
        menuTabCollectionView.translatesAutoresizingMaskIntoConstraints = false
        menuTabCollectionView.register(ExCollectionViewCell.self, forCellWithReuseIdentifier: ExCollectionViewCell.identifier)
        view.addSubview(menuTabCollectionView) // 뷰에 컬렉션 뷰 추가
        
        NSLayoutConstraint.activate([
            menuTabCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor), // 헤더 뷰 아래에 위치
            menuTabCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTabCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTabCollectionView.heightAnchor.constraint(equalToConstant: 40) // 원하는 높이로 설정
        ])
        
        menuTabCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    // MARK: - KVO for scrolling
    // 🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            guard let tableView = object as? UITableView else { return }
            let offset = tableView.contentOffset.y
            
            // 헤더 뷰의 높이 조정
            if offset < 0 {
                headerViewHeightConstraint.constant = 100 - offset // 스크롤이 위로 올라갈 때 헤더 뷰 높이 증가
            } else {
                headerViewHeightConstraint.constant = max(0, 100 - offset) // 헤더 뷰 높이 감소
            }
            
            // 헤더 뷰의 알파 값 조정 (투명도)
            let alpha = max(0, min(1, 1 - (offset / 100))) // 최대 100 포인트 스크롤 시 완전히 투명해짐
            headerView.alpha = alpha
            
            // 타이틀 뷰의 알파 값 조정
            titleView.alpha = max(0, min(1, (offset - 60) / 40)) // 60 포인트 스크롤 시 서서히 나타남
            print("✅ Offset: \(offset), TitleView Alpha: \(titleView.alpha)")

            
            // 컬렉션 뷰를 화면 상단에 고정
            if offset > 99 { // 60 포인트 이상 스크롤 시
                UIView.animate(withDuration: 0.3, animations: {
                    self.headerViewHeightConstraint.constant = 0 // 헤더 뷰 숨기기
                    self.menuTabCollectionView.transform = CGAffineTransform(translationX: 0, y: -self.headerViewHeightConstraint.constant) // 컬렉션 뷰 고정
                    self.view.layoutIfNeeded() // 레이아웃 업데이트
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.menuTabCollectionView.transform = .identity // 원래 위치로 되돌리기
                    self.view.layoutIfNeeded() // 레이아웃 업데이트
                })
            }
        }
    }
    
    private func setupObservers() {
        // 테이블 뷰의 스크롤 위치를 감지하는 이벤트 설정
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
}

// MARK: - UITableViewDelegate

extension TeamInformationViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension TeamInformationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExTableViewCell.identifier, for: indexPath) as? ExTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .systemBackground
        return cell
    }
    
}

// MARK: - UIScrollViewDelegate

extension TeamInformationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            // 테이블 뷰의 컨텐츠 오프셋을 확인
            if tableView.contentOffset.y < 0 {
                // 테이블 뷰의 스크롤을 막음
                tableView.contentOffset.y = 0
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension TeamInformationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = menuTabCollectionView.dequeueReusableCell(withReuseIdentifier: ExCollectionViewCell.identifier, for: indexPath) as? ExCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension TeamInformationViewController: UICollectionViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = menuTabCollectionView.cellForItem(at: indexPath) as? ExCollectionViewCell else { return }
//                cell.updateSelectionState() // 선택된 셀 상태 업데이트
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        guard let cell = menuTabCollectionView.cellForItem(at: indexPath) as? ExCollectionViewCell else { return }
//        cell.updateSelectionState() // 선택 해제된 셀 상태 업데이트
//    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TeamInformationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 셀 간의 수평 간격을 0으로 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 셀 간의 수직 간격을 0으로 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 5 // 5개의 셀을 가로로 배치할 경우
        let height: CGFloat = 40 // 원하는 높이 설정
        return CGSize(width: width, height: height)
    }
    
}
