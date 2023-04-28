//
//  AlbumGalleryCollectionViewCell.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

final class AlbumGalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumGalleryCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemFill
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(withUrl urlString: String) {
//        activityIndicator.startAnimating()
//        if let url = URL(string: urlString) {
//            DispatchQueue.global().async {
//                let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                    guard let data = data, error == nil else { return }
//
//                    DispatchQueue.main.async {
//                        self.activityIndicator.stopAnimating()
//                        self.imageView.image = UIImage(data: data)
//                    }
//                }
//                task.resume()
//            }
//        }
//    }
    
    override func prepareForReuse() {
        activityIndicator.startAnimating()
        imageView.image = nil
    }
}
