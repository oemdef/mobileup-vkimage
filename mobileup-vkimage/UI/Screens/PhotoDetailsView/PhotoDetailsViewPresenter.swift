//
//  PhotoDetailsViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IPhotoDetailsViewPresenter: AnyObject {
    func viewDidLoad()
    func showShareSheet(image: UIImage)
}

final class PhotoDetailsViewPresenter: IPhotoDetailsViewPresenter {
    weak var view: IPhotoDetailsView?
    private let router: IPhotoDetailsViewRouter
    
    init(router: IPhotoDetailsViewRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        // TODO: Implementation
    }
    
    func showShareSheet(image: UIImage) {
        router.showShareSheet(image: image)
    }
}
