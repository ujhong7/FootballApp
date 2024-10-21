//
//  ScrollDelegate.swift
//  FootballApp
//
//  Created by yujaehong on 10/21/24.
//

import Foundation

protocol ScrollDelegate: AnyObject {
    func didScroll(yOffset: CGFloat)
}
