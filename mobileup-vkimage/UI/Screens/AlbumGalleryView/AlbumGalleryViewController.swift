//
//  AlbumGalleryViewController.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAlbumGalleryView: AnyObject {
}

final class AlbumGalleryViewController: UIViewController, IAlbumGalleryView {
    private let presenter: IAlbumGalleryViewPresenter
    
    init(presenter: IAlbumGalleryViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        addSubviews()
        setupConstraints()
        
        presenter.viewDidLoad()
    }
                                                    
    private func addSubviews() {

    }
    
    private func setupConstraints() {

    }
}
