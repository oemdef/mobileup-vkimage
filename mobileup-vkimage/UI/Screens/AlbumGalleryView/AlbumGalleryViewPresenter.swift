//
//  AlbumGalleryViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

protocol IAlbumGalleryViewPresenter: AnyObject {
    func viewDidLoad()
}

final class AlbumGalleryViewPresenter: IAlbumGalleryViewPresenter {
    weak var view: IAlbumGalleryView?
    private let router: IAlbumGalleryViewRouter
    
    init(router: IAlbumGalleryViewRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        // TODO: Implementation
    }
}

