//
//  AlbumGalleryViewController.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAlbumGalleryView: AnyObject {
    func updateState(state: ViewControllerState)
}

enum ViewControllerState {
    case loading, ready
}

final class AlbumGalleryViewController: UIViewController, IAlbumGalleryView {
    private let presenter: IAlbumGalleryViewPresenter
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AlbumGalleryCollectionViewCell.self, forCellWithReuseIdentifier: AlbumGalleryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.minimumLineSpacing = 3
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        flowLayout.sectionInsetReference = .fromSafeArea
        return flowLayout
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    init(presenter: IAlbumGalleryViewPresenter) {
        self.presenter = presenter
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
        title = "MobileUp Gallery"
        let logoutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(tappedLogout))
        navigationItem.rightBarButtonItem = logoutButton
    }
                                                    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateState(state: ViewControllerState) {
        DispatchQueue.main.async {
            switch state {
            case .loading:
                self.collectionView.isHidden = true
                self.activityIndicator.startAnimating()
            case .ready:
                self.collectionView.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func tappedLogout() {
        presenter.logout()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AlbumGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - (view.safeAreaInsets.left + view.safeAreaInsets.right)
        let numberOfItemsPerRow: CGFloat = (!UIDevice.current.orientation.isLandscape) ? 2 : 4
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItemAt(indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension AlbumGalleryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumGalleryCollectionViewCell.identifier, for: indexPath) as? AlbumGalleryCollectionViewCell else {
             return UICollectionViewCell()
        }
        
        return cell
    }
}
