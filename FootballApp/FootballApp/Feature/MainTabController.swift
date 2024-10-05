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
        
        view.backgroundColor = .white
    }
    
    private func configureViewControllers() {
        let news = templateNavigationController(unselectedImage: UIImage(systemName: "newspaper")!, slectedImage: UIImage(systemName: "newspaper.fill")!, rootviewController: NewsViewController())
        let game = templateNavigationController(unselectedImage: UIImage(systemName: "sportscourt")!, slectedImage: UIImage(systemName: "sportscourt.fill")!, rootviewController: GameViewController())
        let video = templateNavigationController(unselectedImage: UIImage(systemName: "play.rectangle")!, slectedImage: UIImage(systemName: "play.rectangle.fill")!, rootviewController: VideoViewController())
        let settings = templateNavigationController(unselectedImage: UIImage(systemName: "gearshape")!, slectedImage: UIImage(systemName: "gearshape.fill")!, rootviewController: SettingsViewController())
        
        viewControllers = [news, game, video, settings]
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
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
    
}
