//
//  StatisticsMapping.swift
//  FootballApp
//
//  Created by yujaehong on 10/31/24.
//

import Foundation

struct StatisticsMapping {
    static let mappingKorean: [String: String] = [
        "Shots on Goal": "유효 슛",
        "Shots off Goal": "비유효 슛",
        "Total Shots": "총 슛",
        "Blocked Shots": "차단 슛",
        "Shots insidebox": "박스 내 슛",
        "Shots outsidebox": "박스 외 슛",
        "Fouls": "파울",
        "Corner Kicks": "코너킥",
        "Offsides": "오프사이드",
        "Ball Possession": "점유율",
        "Yellow Cards": "옐로우 카드",
        "Red Cards": "레드 카드",
        "Goalkeeper Saves": "골키퍼 세이브",
        "Total passes": "총 패스",
        "Passes accurate": "정확한 패스",
        "Passes %": "패스 성공%",
        "expected_goals": "예상 골",
        "goals_prevented": "막힌 골"
    ]
}
