//
//  MainTabController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        setupTabBarAppearance()
    }
    
    private func configureViewControllers() {
        let game = templateNavigationController(unselectedImage: UIImage(systemName: "sportscourt")!, slectedImage: UIImage(systemName: "sportscourt.fill")!, rootviewController: GameViewController())
        let news = templateNavigationController(unselectedImage: UIImage(systemName: "newspaper")!, slectedImage: UIImage(systemName: "newspaper.fill")!, rootviewController: NewsViewController())
        let video = templateNavigationController(unselectedImage: UIImage(systemName: "play.rectangle")!, slectedImage: UIImage(systemName: "play.rectangle.fill")!, rootviewController: VideoViewController())
        let settings = templateNavigationController(unselectedImage: UIImage(systemName: "gearshape")!, slectedImage: UIImage(systemName: "gearshape.fill")!, rootviewController: SettingsViewController())
        
        viewControllers = [game, news, video, settings]
    }
    
    private func templateNavigationController(unselectedImage: UIImage,
                                              slectedImage: UIImage,
                                              rootviewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootviewController)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = slectedImage
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
    
    private func setupTabBarAppearance() {
         // 탭 바의 외관 설정
         let appearance = UITabBarAppearance()
         appearance.configureWithOpaqueBackground() // 불투명 배경 설정
         appearance.backgroundColor = .systemGray4 // 원하는 배경색 설정
         appearance.stackedLayoutAppearance.normal.iconColor = .white // 일반 상태 아이콘 색상
         appearance.stackedLayoutAppearance.selected.iconColor = .white // 선택 상태 아이콘 색상 (예: 노란색으로 설정)
         // Appearance를 탭 바에 적용
         tabBar.standardAppearance = appearance
         tabBar.scrollEdgeAppearance = appearance // 스크롤 시에도 동일한 Appearance 유지
         tabBar.isTranslucent = false // 투명도 설정
     }
    
}
