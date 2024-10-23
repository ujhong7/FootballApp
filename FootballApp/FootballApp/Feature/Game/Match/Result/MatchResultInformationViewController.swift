//
//  MatchResultInformationViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/21/24.
//

import UIKit

class MatchResultInformationViewController: UIViewController {
    
    // MARK: - init
    
    // 커스텀 이니셜라이저로 Fixture 데이터 전달
    init(fixture: Fixture?) {
        self.fixture = fixture
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    var fixture: Fixture?  // 전달받은 경기 정보

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
    private var informationViewHeightConstraint: NSLayoutConstraint?
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
    var currentSegmentIndex: Int = 0
    
    private let homeTeamNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let awayTeamNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let homeTeamLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let awayTeamLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let homeTeamGoalsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let awayTeamGoalsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
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
        setDataMatchInformation()
        setupNavigationBar()
    }
    
    // MARK: - Methods
    
    private func setupBackgroundColor() {
        view.backgroundColor = .footballFieldGreen
        InformationView.backgroundColor = .footballFieldGreen
        segmentedControl.backgroundColor = .footballFieldGreen
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.white // 버튼 색상
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] // 타이틀 색상
    }
    
    private func setDataMatchInformation() {
        // 🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨
        // 전달된 fixture를 사용하여 UI 업데이트
        if let fixture = fixture {
            print("Fixture info: \(fixture)")
            // UI에 경기 정보 표시하는 코드 추가
            let homeTeam = fixture.teams.home
            let awayTeam = fixture.teams.away
            let homeGoals = fixture.goals.home
            let awayGoals = fixture.goals.away
            let status = fixture.fixture.status.long
            let date = fixture.fixture.date
            
            homeTeamNameLabel.text = homeTeam.name
            homeTeamLogoImageView.loadImage(from: homeTeam.logo)
            awayTeamNameLabel.text = awayTeam.name
            awayTeamLogoImageView.loadImage(from: awayTeam.logo)
            homeTeamGoalsLabel.text = "\(homeGoals ?? 0)"
            awayTeamGoalsLabel.text = "\(awayGoals ?? 0)"
            navigationItem.title = "\(teamAbbreviations[homeTeam.name] ?? homeTeam.name)     \(homeGoals ?? 0)   -   \(awayGoals ?? 0)     \(teamAbbreviations[awayTeam.name] ?? awayTeam.name)"
        }
    }
    
    private func setupInformationView() {
        view.addSubview(InformationView)
        InformationView.addSubview(homeTeamNameLabel)
        InformationView.addSubview(awayTeamNameLabel)
        InformationView.addSubview(homeTeamLogoImageView)
        InformationView.addSubview(awayTeamLogoImageView)
        InformationView.addSubview(homeTeamGoalsLabel)
        InformationView.addSubview(awayTeamGoalsLabel)
        InformationView.addSubview(statusLabel)
        InformationView.addSubview(dateLabel)
        InformationView.translatesAutoresizingMaskIntoConstraints = false
        homeTeamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        homeTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        awayTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        homeTeamGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupInformationViewConstraints() {
        informationViewHeightConstraint = InformationView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([
            InformationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            InformationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            InformationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            informationViewHeightConstraint!,
            homeTeamGoalsLabel.centerYAnchor.constraint(equalTo: InformationView.centerYAnchor, constant: -10),
            homeTeamGoalsLabel.centerXAnchor.constraint(equalTo: InformationView.centerXAnchor, constant: -40),
            awayTeamGoalsLabel.centerYAnchor.constraint(equalTo: InformationView.centerYAnchor, constant: -10),
            awayTeamGoalsLabel.centerXAnchor.constraint(equalTo: InformationView.centerXAnchor, constant: 40),
            homeTeamLogoImageView.leadingAnchor.constraint(equalTo: InformationView.leadingAnchor, constant: 40),
            homeTeamLogoImageView.centerYAnchor.constraint(equalTo: InformationView.centerYAnchor, constant: -20),
            awayTeamLogoImageView.trailingAnchor.constraint(equalTo: InformationView.trailingAnchor, constant: -40),
            awayTeamLogoImageView.centerYAnchor.constraint(equalTo: InformationView.centerYAnchor, constant: -20),
            homeTeamLogoImageView.widthAnchor.constraint(equalToConstant: 45),
            homeTeamLogoImageView.heightAnchor.constraint(equalToConstant: 45),
            awayTeamLogoImageView.widthAnchor.constraint(equalToConstant: 45),
            awayTeamLogoImageView.heightAnchor.constraint(equalToConstant: 45),
            homeTeamNameLabel.leadingAnchor.constraint(equalTo: InformationView.leadingAnchor, constant: 15),
            homeTeamNameLabel.topAnchor.constraint(equalTo: homeTeamLogoImageView.bottomAnchor, constant: 10),
            awayTeamNameLabel.trailingAnchor.constraint(equalTo: InformationView.trailingAnchor, constant: -15),
            awayTeamNameLabel.topAnchor.constraint(equalTo: awayTeamLogoImageView.bottomAnchor, constant: 10),
            homeTeamNameLabel.widthAnchor.constraint(equalToConstant: 100),
            awayTeamNameLabel.widthAnchor.constraint(equalToConstant: 100),
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
    
    private func setupViewControllers() {
        let matchVC = Ex2ViewController()
        let playerInfoVC = Ex3ViewController()
        let teamStatsVC = Ex4ViewController()
        let teamInfoVC = Ex5ViewController()
        
        viewControllers = [matchVC, playerInfoVC, teamStatsVC, teamInfoVC]
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

extension MatchResultInformationViewController: UIPageViewControllerDataSource {
    
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

extension MatchResultInformationViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: visibleViewController) {
            segmentedControl.selectedSegmentIndex = index
            currentSegmentIndex = index
            updateUnderLinePosition(for: index) // 바 위치 업데이트
        }
    }
}

// MARK: - ScrollDelegate

extension MatchResultInformationViewController: ScrollDelegate {
    
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
        
        // yOffset에 따라 informationView의 높이를 조정
        let newHeight = max(min(maxHeight - yOffset, maxHeight), minHeight)
        
        let alpha = max(0, min(1, 1 - (yOffset / 100))) // 최대 100 포인트 스크롤 시 완전히 투명해짐
        
        // 애니메이션 처리
        UIView.animate(withDuration: 0.3) {
            self.InformationView.alpha = alpha
            self.informationViewHeightConstraint?.constant = newHeight
            self.view.layoutIfNeeded() // 레이아웃을 즉시 업데이트
        }
    }
}
