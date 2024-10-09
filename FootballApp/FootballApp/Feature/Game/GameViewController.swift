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
    // 자식 뷰 컨트롤러를 위한 변수 추가 ⭐
    var gameResultVC: GameResultViewController?
    var upcomingMatchesVC: UpcomingMatchesViewController?
    var teamRankingVC: TeamRankingViewController?
    var goalsRankingVC: GoalsRankingViewController?
    var assistsRankingVC: AssistsRankingViewController?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupInitialView()
        view.backgroundColor = .white
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
        teamRankingVC = TeamRankingViewController() // 초기 뷰 컨트롤러 인스턴스화 ⭐
        transition(to: teamRankingVC!) // 초기 뷰 전환 ⭐
        let teamRankingVC = TeamRankingViewController()
    }
    
    func transition(to newVC: UIViewController) {
        for child in children {
            if child != newVC { // 새 뷰 컨트롤러와 다른 경우에만 제거 ⭐
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
        
        if !children.contains(newVC) { // 현재 자식 뷰 컨트롤러에 없으면 추가 ⭐
            addChild(newVC)
            newVC.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(newVC.view)
            setupConstraints(for: newVC)
            newVC.didMove(toParent: self)
        }
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
            if teamRankingVC == nil { // 인스턴스가 없을 경우 생성 ⭐
                teamRankingVC = TeamRankingViewController()
            }
            transition(to: teamRankingVC!)
        case 1:
            if gameResultVC == nil { // 인스턴스가 없을 경우 생성 ⭐
                gameResultVC = GameResultViewController()
            }
            transition(to: gameResultVC!)
        case 2:
            if upcomingMatchesVC == nil { // 인스턴스가 없을 경우 생성 ⭐
                upcomingMatchesVC = UpcomingMatchesViewController()
            }
            transition(to: upcomingMatchesVC!)
        case 3:
            if goalsRankingVC == nil { // 인스턴스가 없을 경우 생성 ⭐
                goalsRankingVC = GoalsRankingViewController()
            }
            transition(to: goalsRankingVC!)
        case 4:
            if assistsRankingVC == nil { // 인스턴스가 없을 경우 생성 ⭐
                assistsRankingVC = AssistsRankingViewController()
            }
            transition(to: assistsRankingVC!)
        default:
            break
        }
    }
    
}
