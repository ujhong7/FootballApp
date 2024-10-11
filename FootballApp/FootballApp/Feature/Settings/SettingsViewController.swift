//
//  SettingsViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarUtility.setupNavigationBarAppearance(for: navigationController, backgroundColor: .premierLeaguePurple)
        NavigationTitleUtility.setupNavigationTitle(for: self, title: "설정")
        view.backgroundColor = .green
    }
    
}
