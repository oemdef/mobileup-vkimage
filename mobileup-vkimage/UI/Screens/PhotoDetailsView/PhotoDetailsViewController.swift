//
//  PhotoDetailsViewController.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit
import SDWebImage

protocol IPhotoDetailsView: AnyObject {
}

final class PhotoDetailsViewController: UIViewController, IPhotoDetailsView {
    private let presenter: IPhotoDetailsViewPresenter
    private let photo: Photo
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    init(presenter: IPhotoDetailsViewPresenter, photo: Photo) {
        self.presenter = presenter
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavbar()

        addSubviews()
        setupConstraints()
        
        presenter.viewDidLoad()
    }
    
    private func setupNavbar() {
        title = photo.date
        imageView.sd_setImage(with: photo.photoUrl, placeholderImage: UIImage(named: "placeholder")!)
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tappedShare))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc private func tappedShare() {
        
    }
                                                    
    private func addSubviews() {
        view.addSubview(imageView)
        imageView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}

