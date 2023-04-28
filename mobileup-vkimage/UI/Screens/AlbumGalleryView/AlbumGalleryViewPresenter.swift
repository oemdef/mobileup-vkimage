//
//  AlbumGalleryViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

protocol IAlbumGalleryViewPresenter: AnyObject {
    func viewDidLoad()
    func logout()
    
    func numberOfSections() -> Int
    func numberOfItemsInSection (section: Int) -> Int
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
    
    func logout() {
        // TODO: Implement Logout Call to API
        
        AuthService.standard.clearAccessToken()
        router.logoutAndPopToRoot()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection (section: Int) -> Int {
        return 17
    }
}

