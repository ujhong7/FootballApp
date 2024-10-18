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
        view.backgroundColor = .premierLeaguePurple // white
        setupNavigationBar()
        setupSegmentedControl()
        setupInitialView()
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        NavigationTitleUtility.setupNavigationTitle(for: self, title: "Premier League")
        
        // "pl" 이미지를 UIImage로 생성
        let image = UIImage(named: "pl")
        
        // 이미지의 크기를 설정 (필요에 따라 조정)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 왼쪽 바 버튼 아이템으로 설정
        let imageBarButtonItem = UIBarButtonItem(customView: imageView)
        
        // 바 버튼 아이템의 크기를 설정하여 이미지가 잘 보이도록 조정
        imageBarButtonItem.width = 40 // 원하는 크기로 조정
        
        // 네비게이션 아이템에 추가
        self.navigationItem.leftBarButtonItem = imageBarButtonItem
        
        // 이미지 뷰의 제약 조건 설정 (높이 및 너비)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 30), // 높이 조정
            imageView.widthAnchor.constraint(equalToConstant: 30)   // 너비 조정
        ])
    }
    
    private func setupSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // 선택되지 않은 세그먼트의 텍스트 색상
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal) // gray
        // 선택된 세그먼트의 텍스트 색상
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.premierLeaguePurple, .font: UIFont.boldSystemFont(ofSize: 14)], for: .selected)
        // 선택되지 않은 세그먼트의 배경색
        segmentedControl.backgroundColor = UIColor.systemGray6 // systemGray6
        // 선택된 세그먼트의 배경색
        segmentedControl.selectedSegmentTintColor = .white // premierLeaguePurple
        
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
