//
//  AssistsPlayerInformationViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/21/24.
//

import UIKit

class AssistsPlayerInformationViewController: UIViewController {
    
    // MARK: - init
    
    init(playerRanking: PlayerRanking?) {
        self.playerRanking = playerRanking
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    var playerRanking: PlayerRanking?
    
    private let InformationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["프로필", "경기", "통계", "경력"])
        control.selectedSegmentIndex = 0 // 기본적으로 첫 번째 탭 선택
        control.backgroundColor = .white
        control.selectedSegmentTintColor = .systemBlue
        return control
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var underlineLeadingConstraint: NSLayoutConstraint?
    private var InformationViewHeightConstraint: NSLayoutConstraint?
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
    var currentSegmentIndex: Int = 0

    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let playerTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let playerPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playeTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInformationView()
        setupInformationViewConstraints()
        setupSegmentedControl()
        setupSegmentedControlConstraints()
        setupUnderLineView()
        setupViewControllers()
        setupPageViewController()
        setupScrollDelegates()
        setupBackgroundColor()
        setDataPlayerInformation()
        setupNavigationBar()
    }
    
    // MARK: - Methods
    
    private func setupBackgroundColor() {
        if let playerRanking = playerRanking {
            view.backgroundColor = TeamColors.color(for: playerRanking.statistics.first?.team.name ?? "")
            InformationView.backgroundColor = TeamColors.color(for: playerRanking.statistics.first?.team.name ?? "")
            segmentedControl.backgroundColor = TeamColors.color(for: playerRanking.statistics.first?.team.name ?? "")
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.white // 버튼 색상
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] // 타이틀 색상
    }
    
    private func setDataPlayerInformation() {
        if let playerRanking = playerRanking {
            navigationItem.title = playerRanking.player.name
            playerNameLabel.text = playerRanking.player.name
            playerPhotoImageView.loadImage(from: playerRanking.player.photo)
            playerTeamLabel.text = playerRanking.statistics.first?.team.name
            playeTeamImageView.loadImage(from: playerRanking.statistics.first?.team.logo ?? "")
        }
    }
    
    private func setupViewControllers() {
        let matchVC = Ex2ViewController()
        let playerInfoVC = Ex3ViewController()
        let teamStatsVC = Ex4ViewController()
        let teamInfoVC = Ex5ViewController()
        viewControllers = [matchVC, playerInfoVC, teamStatsVC, teamInfoVC]
    }
    
    private func setupInformationView() {
        view.addSubview(InformationView)
        InformationView.addSubview(playerPhotoImageView)
        InformationView.addSubview(playerNameLabel)
        InformationView.addSubview(playerTeamLabel)
        InformationView.addSubview(playeTeamImageView)
        InformationView.translatesAutoresizingMaskIntoConstraints = false
        playerPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        playerTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        playeTeamImageView.translatesAutoresizingMaskIntoConstraints = false
//        InformationViewHeightConstraint = InformationView.heightAnchor.constraint(equalToConstant: 100) // 초기 헤더 높이 설정
    }
    
    private func setupInformationViewConstraints() {
        InformationViewHeightConstraint = InformationView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([
            InformationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            InformationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            InformationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            InformationViewHeightConstraint!,
            playerPhotoImageView.centerYAnchor.constraint(equalTo: InformationView.centerYAnchor),
            playerPhotoImageView.leadingAnchor.constraint(equalTo: InformationView.leadingAnchor, constant: 10),
            playerPhotoImageView.widthAnchor.constraint(equalToConstant: 80),
            playerPhotoImageView.heightAnchor.constraint(equalToConstant: 80),
            playerNameLabel.centerYAnchor.constraint(equalTo: InformationView.centerYAnchor, constant: -20),
            playerNameLabel.leadingAnchor.constraint(equalTo: playerPhotoImageView.trailingAnchor, constant: 15),
            playerTeamLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 7),
            playerTeamLabel.leadingAnchor.constraint(equalTo: playeTeamImageView.trailingAnchor, constant: 9),
            playeTeamImageView.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 5),
            playeTeamImageView.leadingAnchor.constraint(equalTo: playerPhotoImageView.trailingAnchor, constant: 15),
            playeTeamImageView.widthAnchor.constraint(equalToConstant: 30),
            playeTeamImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.layer.cornerRadius = 0
        segmentedControl.layer.masksToBounds = true
    }
    
    private func setupSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: InformationView.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupUnderLineView() {
        view.addSubview(underLineView)
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        
        let segmentWidth = view.bounds.width / CGFloat(segmentedControl.numberOfSegments)
        underlineLeadingConstraint = underLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        
        NSLayoutConstraint.activate([
            underLineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 4),
            underLineView.widthAnchor.constraint(equalToConstant: segmentWidth),
            underlineLeadingConstraint!
        ])
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // 첫 번째 뷰 컨트롤러 표시
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        setupPageViewControllerConstraints()
        pageViewController.didMove(toParent: self)
    }
    
    private func setupPageViewControllerConstraints() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func segmentChanged() {
        let newSegmentIndex = segmentedControl.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = newSegmentIndex > currentSegmentIndex ? .forward : .reverse
        
        pageViewController.setViewControllers([viewControllers[newSegmentIndex]], direction: direction, animated: true, completion: nil)
        updateUnderLinePosition(for: newSegmentIndex) // 바 위치 업데이트
        currentSegmentIndex = newSegmentIndex
    }
    
    private func updateUnderLinePosition(for index: Int) {
        let segmentWidth = segmentedControl.bounds.width / CGFloat(segmentedControl.numberOfSegments)
        let xPosition = segmentWidth * CGFloat(index)
        
        underlineLeadingConstraint?.constant = xPosition
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded() // AutoLayout을 사용한 애니메이션
        }
    }
    
}

// MARK: - UIPageViewControllerDataSource

extension AssistsPlayerInformationViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return viewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 else {
            return nil
        }
        return viewControllers[index + 1]
    }
}

// MARK: - UIPageViewControllerDelegate

extension AssistsPlayerInformationViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: visibleViewController) {
            segmentedControl.selectedSegmentIndex = index
            currentSegmentIndex = index
            updateUnderLinePosition(for: index) // 바 위치 업데이트
        }
    }
}

// MARK: - ScrollDelegate

extension AssistsPlayerInformationViewController: ScrollDelegate {
    
    private func setupScrollDelegates() {
        // 각 하위 뷰컨트롤러의 스크롤 델리게이트 설정
        if let ex2VC = viewControllers[0] as? Ex2ViewController {
            ex2VC.scrollDelegate = self
        }
        if let ex3VC = viewControllers[1] as? Ex3ViewController {
            ex3VC.scrollDelegate = self
        }
        if let ex4VC = viewControllers[2] as? Ex4ViewController {
            ex4VC.scrollDelegate = self
        }
        if let ex5VC = viewControllers[3] as? Ex5ViewController {
            ex5VC.scrollDelegate = self
        }
    }
    
    func didScroll(yOffset: CGFloat) {
        print(#fileID, #function, #line, "🐧 yOffset:\(yOffset)")
        
        // 최소 및 최대 높이 설정 (필요에 따라 변경 가능)
        let minHeight: CGFloat = 0
        let maxHeight: CGFloat = 100
        
        // yOffset에 따라 InformationView의 높이를 조정
        let newHeight = max(min(maxHeight - yOffset, maxHeight), minHeight)
        
        let alpha = max(0, min(1, 1 - (yOffset / 100))) // 최대 100 포인트 스크롤 시 완전히 투명해짐
        
        // 애니메이션 처리
        UIView.animate(withDuration: 0.3) {
            self.InformationView.alpha = alpha
            self.InformationViewHeightConstraint?.constant = newHeight
            self.view.layoutIfNeeded() // 레이아웃을 즉시 업데이트
        }
    }
}

