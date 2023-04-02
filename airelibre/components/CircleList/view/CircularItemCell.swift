//
//  CircularItemCell.swift
//  airelibre
//
//  Created by MacBook Pro on 2023-04-02.
//

import Foundation
import UIKit

class CircularItemCell:UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true

        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 65),
            imageView.heightAnchor.constraint(equalToConstant: 65),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: CircularItemModel, isSelected: Bool) {
        imageView.image = model.image
        titleLabel.text = model.title
        
        if isSelected {
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.green.cgColor
        } else {
            imageView.layer.borderWidth = 0
        }
    }
}
