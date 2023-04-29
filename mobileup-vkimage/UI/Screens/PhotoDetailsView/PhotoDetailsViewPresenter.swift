//
//  PhotoDetailsViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

protocol IPhotoDetailsViewPresenter: AnyObject {
    func viewDidLoad()
    func getPhoto() -> AlbumItem
}

final class PhotoDetailsViewPresenter: IPhotoDetailsViewPresenter {
    weak var view: IPhotoDetailsView?
    private let router: IPhotoDetailsViewRouter
    private let photo: AlbumItem
    
    init(photo: AlbumItem, router: IPhotoDetailsViewRouter) {
        self.photo = photo
        self.router = router
    }
    
    func viewDidLoad() {
        // TODO: Implementation
    }
    
    func getPhoto() -> AlbumItem {
        return photo
    }
}
