//
//  PhotoDetailsViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

protocol IPhotoDetailsViewPresenter: AnyObject {
    func viewDidLoad()
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
}
