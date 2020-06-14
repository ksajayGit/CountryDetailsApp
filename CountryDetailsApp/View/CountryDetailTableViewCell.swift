//
//  CountryDetailTableViewCell.swift
//  CountryDetailsApp
//
//  Created by MyHome on 14/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import UIKit

class CountryDetailTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let containerStackview: UIStackView = {
        let stkView = UIStackView()
        stkView.axis = .vertical
        stkView.translatesAutoresizingMaskIntoConstraints = false
        return stkView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 35.0/255.0, green: 70.0/255.0, blue: 120.0/255.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        layer.borderWidth = 1
        layer.cornerRadius = 3
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        layer.shadowOpacity = 0.18
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 1.5
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        
        self.contentView.addSubview(profileImageView)
        containerStackview.addArrangedSubview(titleLabel)
        containerStackview.addArrangedSubview(descriptionLabel)
        self.contentView.addSubview(containerStackview)
        
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 5).isActive = true
        profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        
        profileImageView.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 70.0).isActive = true
        
        containerStackview.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        containerStackview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        containerStackview.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        containerStackview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        
        titleLabel.widthAnchor.constraint(equalTo: self.containerStackview.widthAnchor, multiplier: 0).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.containerStackview.widthAnchor, multiplier: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
