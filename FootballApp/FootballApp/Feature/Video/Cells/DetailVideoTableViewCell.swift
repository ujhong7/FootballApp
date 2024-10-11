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
        self.backgroundColor = .premierLeagueBackgroundColor
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
        
        authorLabel.font = UIFont.boldSystemFont(ofSize: 15)
        commentLabel.numberOfLines = 2
        commentLabel.font = UIFont.systemFont(ofSize: 13)
        
        [profileImageView, authorLabel, commentLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
//            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            authorLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 14),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            commentLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 14),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            commentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func configure(with comment: Comment) {
        let imageUrl = comment.snippet.authorProfileImageUrl
        profileImageView.loadImage(from: imageUrl)
        authorLabel.text = comment.snippet.authorDisplayName
        commentLabel.text = comment.snippet.textDisplay
    }
    
}
