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
    func cellForItemAt(_ indexPath: IndexPath) -> AlbumItem
    func didSelectItemAt(_ indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection (section: Int) -> Int
}

final class AlbumGalleryViewPresenter: IAlbumGalleryViewPresenter {
    weak var view: IAlbumGalleryView?
    private let router: IAlbumGalleryViewRouter
    
    private var albumItems: [AlbumItem] = []
    
    init(router: IAlbumGalleryViewRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        view?.updateState(state: .loading)
        
        DispatchQueue.global().async {
            NetworkService.standard.getResponse { [weak self] (response) in
                guard let response = response else { return }
                
                self?.albumItems = response.items
                self?.view?.reloadData()
                self?.view?.updateState(state: .ready)
            }
        }
    }
    
    func logout() {
        // TODO: Implement Logout Call to API
//        AuthService.standard.clearAccessToken()
        router.logoutAndPopToRoot()
    }
    
    func cellForItemAt(_ indexPath: IndexPath) -> AlbumItem {
        return albumItems[indexPath.row]
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        router.showPhotoDetailsView(photo: albumItems[indexPath.row])
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection (section: Int) -> Int {
        return albumItems.count
    }
}

