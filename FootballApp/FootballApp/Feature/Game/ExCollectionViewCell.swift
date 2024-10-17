//
//  ExCollectionViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/16/24.
//

import UIKit

class ExCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExCollectionViewCell"
    
    // 레이블 정의
    private let label: UILabel = {
        let label = UILabel()
        label.text = "예시"
        label.textColor = .systemGray6
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 선택된 셀을 표시할 하단 바 정의
    private let selectedBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.isHidden = true // 기본적으로 숨김
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
        
        // 선택된 상태를 보여줄 바의 오토레이아웃 설정
        NSLayoutConstraint.activate([
            selectedBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selectedBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            selectedBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            selectedBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
//            selectedBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 25),
            selectedBar.heightAnchor.constraint(equalToConstant: 4), // 바의 높이 설정
            selectedBar.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 선택 상태에 따른 UI 업데이트
    func updateSelectionState() {
        if isSelected {
            label.textColor = .white
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 17)
            selectedBar.isHidden = false // 선택된 셀에 하단 바 표시
        } else {
            label.textColor = .systemGray6
            selectedBar.isHidden = true // 선택되지 않은 셀에 바 숨김
        }
    }
}

