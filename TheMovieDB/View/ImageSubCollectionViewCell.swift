//
//  ImageSubCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import UIKit

class ImageSubCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rustem Akylbaev"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func setupViews(){
        addSubview(imageView)
        addSubview(nameLabel)
        addConstraintsWithFormat(format: "H:|[v0(150)]|", views: imageView)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
