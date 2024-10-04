//
//  NewsTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell" // Identifier 설정
    
    private let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16) // 폰트 사이즈 설정
        label.textColor = .black // 텍스트 색상 설정
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // 셀의 배경색을 밝은 회색으로 설정
        backgroundColor = UIColor(white: 0.95, alpha: 1) // 밝은 회색
        
        // 커스텀 레이블 추가
        addSubview(customLabel)

        // 레이블 제약 조건 설정
        NSLayoutConstraint.activate([
            customLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            customLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            customLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            customLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    // 셀의 데이터 설정 메서드
    func configure(with text: String) {
        customLabel.text = text // 텍스트 레이블에 데이터 설정
    }
}

