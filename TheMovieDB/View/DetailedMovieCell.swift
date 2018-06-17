//
//  DetailedMovieCell.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import UIKit

class DetailedMovieCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    
    func setupViews(){
        addSubview(backgroundImage)
        addSubview(containerView)
        containerView.addSubview(posterImage)
        containerView.addSubview(containerOfTitleAndRuntime)
        containerOfTitleAndRuntime.addSubview(titleLabel)
        containerOfTitleAndRuntime.addSubview(runtime)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(imagesCollectionView)
        
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(ImageSubCollectionViewCell.self, forCellWithReuseIdentifier: imageCellId)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImage)
        addConstraintsWithFormat(format: "V:|[v0(300)]", views: backgroundImage)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: containerView)
        addConstraintsWithFormat(format: "V:|-100-[v0]|", views: containerView)
        
        addConstraintsWithFormat(format: "H:|[v0(150)]", views: posterImage)
        addConstraintsWithFormat(format: "H:|[v0]|", views: containerOfTitleAndRuntime)
        addConstraintsWithFormat(format: "H:|[v0]|", views: descriptionLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imagesCollectionView)
        addConstraintsWithFormat(format: "V:|[v0(200)]-10-[v1(23)]-6-[v2]-13-[v3(200)]", views: posterImage,containerOfTitleAndRuntime,descriptionLabel,imagesCollectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]-20-[v1(70)]", views: titleLabel, runtime)
        addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|[v0(20)]|", views: runtime)
        
        
        
    }
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let containerOfTitleAndRuntime: UIView = {
        let view = UIView()
        return view
    }()
    
    let posterImage: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        return poster
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let runtime: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = UIColor.rgb(red: 1, green: 210, blue: 119)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        return label
    }()
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let imageCellId = "imageCellId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath) as! ImageSubCollectionViewCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


