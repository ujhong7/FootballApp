//
//  MatchInformationViewController.swift
//  FootballApp
//
//  Created by yujaehong on 10/15/24.
//

import UIKit

class MatchInformationViewController: UIViewController {
    
    var selectedIndex: Int? // 전달받을 선택된 셀의 인덱스
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        if let selectedIndex = selectedIndex {
            print("선택된 셀의 인덱스: \(selectedIndex)")
        }
    }
    
}
