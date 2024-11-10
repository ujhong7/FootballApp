//
//  RoundTabCollectionViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/14/24.
//

import UIKit

class RoundTabCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "RoundCollectionViewCell"
    
    private let roundLabel: UILabel = {
        let label = UILabel()
        label.text = "예시"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .premierLeaguePurple
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.isHidden = false
        return bar
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupSelectedBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupConstraints() {
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(roundLabel)
        NSLayoutConstraint.activate([
            roundLabel.widthAnchor.constraint(equalToConstant: 45),
            roundLabel.heightAnchor.constraint(equalToConstant: 30),
            roundLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    private func setupSelectedBar() {
        contentView.addSubview(selectedBar)
        NSLayoutConstraint.activate([
            selectedBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selectedBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            selectedBar.heightAnchor.constraint(equalToConstant: 8),
            selectedBar.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(round: Int) {
        roundLabel.text = "\(round) R"
    }
    
    func changeSelectedColor(isSelected: Bool) {
        roundLabel.textColor = isSelected ? .premierLeaguePurple : .gray
        selectedBar.isHidden = !isSelected // 선택되면 표시, 아니면 숨김
    }
}
