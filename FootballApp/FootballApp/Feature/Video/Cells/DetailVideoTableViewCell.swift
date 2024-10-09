//  DetailVideoTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/8/24.
//

import UIKit

final class DetailVideoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "DetailVideoTableViewCell"

    private let profileImageView = UIImageView()
    private let authorLabel = UILabel()
    private let commentLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 20
        
        authorLabel.font = UIFont.boldSystemFont(ofSize: 14)
        commentLabel.numberOfLines = 0
        
        [profileImageView, authorLabel, commentLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            authorLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            commentLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            commentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with comment: Comment) {
        // 프로필 이미지 설정
        if let imageUrl = URL(string: comment.snippet.authorProfileImageUrl) {
            // 이미지 다운로드 (비동기 처리 필요)
            // 여기서는 Kingfisher 또는 다른 라이브러리를 사용해도 좋습니다.
            // 예: profileImageView.kf.setImage(with: imageUrl)
        }
        
        authorLabel.text = comment.snippet.authorDisplayName
        commentLabel.text = comment.snippet.textDisplay
    }
    
}
