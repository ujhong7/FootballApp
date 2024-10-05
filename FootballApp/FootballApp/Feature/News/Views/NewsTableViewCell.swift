//
//  NewsTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/4/24.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell" // Identifier 설정
    
    // 기사 제목 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18) // 볼드체 폰트
        label.textColor = .black
        label.numberOfLines = 2 // 최대 2줄까지 표시
        return label
    }()
    
    // 기사 내용 레이블 (간략한 요약)
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 3 // 최대 3줄까지 표시
        return label
    }()
    
    // 기사 날짜 레이블
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
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
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        
        // 레이블 제약 조건 설정
        
        NSLayoutConstraint.activate([
            // 제목 레이블 제약 조건
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            // 내용 레이블 제약 조건
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            // 날짜 레이블 제약 조건
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // 셀의 데이터 설정 메서드
    func configure(with newsItem: NewsItem) {
        titleLabel.text = newsItem.title // 기사 제목 설정
        descriptionLabel.text = newsItem.description // 기사 내용 요약 설정
        dateLabel.text = newsItem.pubDate // 기사 날짜 설정
    }
}

