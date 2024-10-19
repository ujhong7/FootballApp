//
//  CategoryTabTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/18/24.
//

import UIKit

class CategoryTabTableViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryTabTableViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "예시"
        label.textColor = .systemGray6
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.isHidden = true
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLabel()
        setupSelectedBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀이 선택되었을 때 상태 변경 처리
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }
    
    private func setupCell() {
//        contentView.backgroundColor = .systemBlue
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        // 레이블 오토레이아웃 설정
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupSelectedBar() {
        contentView.addSubview(selectedBar)
        NSLayoutConstraint.activate([
            selectedBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selectedBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            selectedBar.heightAnchor.constraint(equalToConstant: 4),
            selectedBar.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 선택 상태에 따른 UI 업데이트
    func updateSelectionState() {
        if isSelected {
            label.textColor = .white
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 17)
            selectedBar.isHidden = false
        } else {
            label.textColor = .systemGray6
            selectedBar.isHidden = true
        }
    }
}

