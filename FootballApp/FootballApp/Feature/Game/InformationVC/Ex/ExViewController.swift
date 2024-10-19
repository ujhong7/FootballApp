//
//  ExViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/19/24.
//


import UIKit

protocol ScrollDelegate: AnyObject {
    func didScroll(yOffset: CGFloat)
}

class ExViewController: UIViewController, ScrollDelegate {
    
    // MARK: - Properties
    
    private let headerView: UIView = {
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
    private var headerViewHeightConstraint: NSLayoutConstraint?
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
    var currentSegmentIndex: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupHeaderViewConstraints()
        setupSegmentedControl()
        setupSegmentedControlConstraints()
        setupUnderLineView()
        setupViewControllers()
        setupPageViewController()
        setupScrollDelegates()
        setupBackgroundColor()
    }
    
    // MARK: - Methods
    
    private func setupBackgroundColor() {
        view.backgroundColor = .systemRed
        headerView.backgroundColor = .systemRed
        segmentedControl.backgroundColor = .systemRed
    }
    
    private func setupScrollDelegates() {
        // 각 하위 뷰컨트롤러의 스크롤 델리게이트 설정
        if let ex2VC = viewControllers[0] as? Ex2ViewController {
            ex2VC.scrollDelegate = self
        }
    }
    
    func didScroll(yOffset: CGFloat) {
        print(#fileID, #function, #line, "🐧 yOffset:\(yOffset)")
        
        // 최소 및 최대 높이 설정 (필요에 따라 변경 가능)
        let minHeight: CGFloat = 0
        let maxHeight: CGFloat = 100
        
        // yOffset에 따라 headerView의 높이를 조정
        let newHeight = max(min(maxHeight - yOffset, maxHeight), minHeight)
        
        let alpha = max(0, min(1, 1 - (yOffset / 100))) // 최대 100 포인트 스크롤 시 완전히 투명해짐
        
        // 애니메이션 처리
        UIView.animate(withDuration: 0.3) {
            self.headerView.alpha = alpha
            self.headerViewHeightConstraint?.constant = newHeight
            self.view.layoutIfNeeded() // 레이아웃을 즉시 업데이트
        }
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHeaderViewConstraints() {
        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerViewHeightConstraint!
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
            segmentedControl.topAnchor.constraint(equalTo: headerView.bottomAnchor),
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

extension ExViewController: UIPageViewControllerDataSource {
    
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

extension ExViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: visibleViewController) {
            segmentedControl.selectedSegmentIndex = index
            currentSegmentIndex = index
            updateUnderLinePosition(for: index) // 바 위치 업데이트
        }
    }
}
