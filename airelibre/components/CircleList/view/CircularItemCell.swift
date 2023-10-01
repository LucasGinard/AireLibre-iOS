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
        titleLabel.font = UIFont(name: "Rubik-Bold", size: 16)
        
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
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureForMap(with model: CircularItemModel, isSelected: Bool) {
        self.imageView.image = model.image
        self.titleLabel.text = model.title
        
        if isSelected {
            self.imageView.layer.borderWidth = 2
            self.imageView.layer.borderColor = UIColor.green.cgColor
        } else {
            self.imageView.layer.borderWidth = 0
        }
    }
    
    func configureForContributor(with contributor: Contributor) {
        self.contentView.backgroundColor = .clear
        self.titleLabel.text = contributor.nameContributor
        self.imageView.layer.borderWidth = 0
        
        let sizeTitle = contributor.nameContributor.count > 8 ? 8 : 10
        self.titleLabel.font = UIFont(name: "Rubik-Bold", size: CGFloat(sizeTitle))
 
        let imageURLString = contributor.profileImage
        
        if let imageURL = URL(string: imageURLString) {
            let task = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
            
            task.resume()
        }
        
    }
}
