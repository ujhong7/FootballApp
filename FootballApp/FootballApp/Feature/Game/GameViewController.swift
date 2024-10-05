//
//  BookmarkViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    let segmentedControl = UISegmentedControl(items: ["경기결과", "예정경기", "득점순위", "도움순위"])
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupInitialView()
        view.backgroundColor = .orange
    }
    
    
    // MARK: - Methods
    
    private func setupSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
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
    
    func setupInitialView() {
        let gameResultVC = GameResultViewController()
        
        addChild(gameResultVC)
        gameResultVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameResultVC.view)
        setupConstraints(for: gameResultVC)
        gameResultVC.didMove(toParent: self)
    }
    
    func transition(to newVC: UIViewController) {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        addChild(newVC)
        newVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newVC.view)
        setupConstraints(for: newVC)
        newVC.didMove(toParent: self)
    }
    
    private func setupConstraints(for viewController: UIViewController) {
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let gameResultVC = GameResultViewController()
            transition(to: gameResultVC)
        case 1:
            let upcomingMatchesVC = UpcomingMatchesViewController()
            transition(to: upcomingMatchesVC)
        case 2:
            let goalsRankingVC = GoalsRankingViewController()
            transition(to: goalsRankingVC)
        case 3:
            let assistsRankingVC = AssistsRankingViewController()
            transition(to: assistsRankingVC)
        default:
            break
        }
    }
    
}
