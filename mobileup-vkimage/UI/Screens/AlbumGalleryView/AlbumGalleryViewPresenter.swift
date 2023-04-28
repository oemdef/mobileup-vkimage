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
    func didSelectItemAt(_ indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection (section: Int) -> Int
}

final class AlbumGalleryViewPresenter: IAlbumGalleryViewPresenter {
    weak var view: IAlbumGalleryView?
    private let router: IAlbumGalleryViewRouter
    
    private let albumItems: [AlbumItem] = []
    
    init(router: IAlbumGalleryViewRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        view?.updateState(state: .loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.view?.updateState(state: .ready)
        }
    }
    
    func logout() {
        // TODO: Implement Logout Call to API
//        AuthService.standard.clearAccessToken()
        router.logoutAndPopToRoot()
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        router.showPhotoDetailsView()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection (section: Int) -> Int {
        return 17
    }
}

