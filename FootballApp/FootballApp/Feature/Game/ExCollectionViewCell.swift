//
//  ExCollectionViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/16/24.
//

import UIKit

class ExCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExCollectionViewCell"
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupCell()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       private func setupCell() {
           contentView.backgroundColor = .green // 셀의 배경색 설정
           contentView.layer.cornerRadius = 5 // 셀의 모서리 둥글게 만들기
           contentView.clipsToBounds = true // 모서리 둥글게 만든 부분이 잘리도록 설정
           
           // 테두리 설정
           contentView.layer.borderColor = UIColor.black.cgColor // 테두리 색상
           contentView.layer.borderWidth = 2 // 테두리 두께
       }
    

}
