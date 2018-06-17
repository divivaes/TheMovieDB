//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    
    let posterImage: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        return poster
    }()
    let informationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.rgb(red: 1, green: 210, blue: 119)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    
    func setupViews(){
        backgroundColor = .white
        addSubview(posterImage)
        addSubview(informationView)
        posterImage.addSubview(ratingLabel)
        informationView.addSubview(titleLabel)
        informationView.addSubview(descriptionLabel)
        
        addConstraintsWithFormat(format: "H:|[v0(150)]-8-[v1]-8-|", views: posterImage, informationView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: posterImage)
        addConstraintsWithFormat(format: "V:|[v0]|", views: informationView)
        addConstraintsWithFormat(format: "H:[v0(40)]-3-|", views: ratingLabel)
        addConstraintsWithFormat(format: "V:[v0(40)]-3-|", views: ratingLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: descriptionLabel)
        addConstraintsWithFormat(format: "V:|-7-[v0]-5-[v1]", views: titleLabel, descriptionLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
