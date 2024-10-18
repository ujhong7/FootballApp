//
//  NavigationTitleUtility.swift
//  FootballApp
//
//  Created by yujaehong on 10/11/24.
//
//

import UIKit

class NavigationTitleUtility {
    
    static func setupNavigationTitle(for viewController: UIViewController, title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 22) ?? UIFont.boldSystemFont(ofSize: 22) // 기본 폰트 설정
        titleLabel.textColor = .white // premierLeaguePurple
        titleLabel.textAlignment = .center
        
        viewController.navigationItem.titleView = titleLabel
    }
}

class NavigationBarUtility {
    
    /// 네비게이션 바 Appearance 설정
    static func setupNavigationBarAppearance(for navigationController: UINavigationController?, backgroundColor: UIColor, titleColor: UIColor = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        
        // 스크롤 시에도 배경색이 유지되도록 설정
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
