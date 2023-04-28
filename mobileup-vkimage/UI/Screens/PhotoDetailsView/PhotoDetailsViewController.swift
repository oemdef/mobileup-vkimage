//
//  PhotoDetailsViewController.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IPhotoDetailsView: AnyObject {
}

final class PhotoDetailsViewController: UIViewController, IPhotoDetailsView {
    private let presenter: IPhotoDetailsViewPresenter
    
    init(presenter: IPhotoDetailsViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed

        addSubviews()
        setupConstraints()
        
        presenter.viewDidLoad()
    }
                                                    
    private func addSubviews() {

    }
    
    private func setupConstraints() {

    }
}

