//
//  BookmarkViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    let segmentedControl = UISegmentedControl(items: ["팀순위", "경기결과", "경기예정", "득점순위", "도움순위"])
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
    var currentSegmentIndex: Int = 0
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .premierLeaguePurple
        setupNavigationBar()
        setupSegmentedControl()
        setupViewControllers()
        setupPageViewController()
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        NavigationTitleUtility.setupNavigationTitle(for: self, title: "Premier League")
        let image = UIImage(named: "pl")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageBarButtonItem = UIBarButtonItem(customView: imageView)
        imageBarButtonItem.width = 40
        self.navigationItem.leftBarButtonItem = imageBarButtonItem
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.premierLeaguePurple, .font: UIFont.boldSystemFont(ofSize: 14)], for: .selected)
        segmentedControl.backgroundColor = UIColor.systemGray6
        segmentedControl.selectedSegmentTintColor = .white
        
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    private func setupViewControllers() {
        let teamRankingVC = TeamRankingViewController()
        let gameResultVC = GameResultViewController()
        let upcomingMatchesVC = UpcomingMatchesViewController()
        let goalsRankingVC = GoalsRankingViewController()
        let assistsRankingVC = AssistsRankingViewController()
        
        viewControllers = [teamRankingVC, gameResultVC, upcomingMatchesVC, goalsRankingVC, assistsRankingVC]
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
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func segmentChanged() {
        let newSegmentIndex = segmentedControl.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = newSegmentIndex > currentSegmentIndex ? .forward : .reverse
        
        pageViewController.setViewControllers([viewControllers[newSegmentIndex]], direction: direction, animated: true, completion: nil)
        currentSegmentIndex = newSegmentIndex
    }
}

// MARK: - UIPageViewControllerDataSource

extension GameViewController: UIPageViewControllerDataSource {
    
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

extension GameViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: visibleViewController) {
            segmentedControl.selectedSegmentIndex = index
            currentSegmentIndex = index
        }
    }
}
