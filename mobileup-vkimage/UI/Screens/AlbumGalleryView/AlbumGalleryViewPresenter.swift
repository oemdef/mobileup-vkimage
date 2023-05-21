//
//  AlbumGalleryViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

protocol IAlbumGalleryViewPresenter: AnyObject {
    func makePhotoModels(from albumItems: [AlbumItem]) -> [Photo]
    func viewDidLoad()
    func logout()
    func cellForItemAt(_ indexPath: IndexPath) -> Photo
    func didSelectItemAt(_ indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection (section: Int) -> Int
}

final class AlbumGalleryViewPresenter: IAlbumGalleryViewPresenter {
    weak var view: IAlbumGalleryView?
    private let router: IAlbumGalleryViewRouter
    
    private let useSwiftConcurrency: Bool = true
    
    private var albumItems: [AlbumItem] = [] {
        didSet {
            photos = makePhotoModels(from: albumItems)
        }
    }
    
    private var photos: [Photo] = []
    
    init(router: IAlbumGalleryViewRouter) {
        self.router = router
    }
    
    func makePhotoModels(from albumItems: [AlbumItem]) -> [Photo] {
        var photos: [Photo] = []
        for item in albumItems {
            let dateForTitle = Date(timeIntervalSince1970: item.date)
            let date = DateFormatter.titleFormatter.string(from: dateForTitle)
            var photoUrl: String = ""
            
            let sizes = item.sizes
            for size in sizes {
                if size.type == "z" {
                    photoUrl = size.url
                }
            }
            if let photoUrl = URL(string: photoUrl) {
                photos.append(Photo(date: date, photoUrl: photoUrl))
            }
        }
        return photos
    }
    
    func viewDidLoad() {
        view?.updateState(state: .loading)

        useSwiftConcurrency ? scRequestOnLoad() : defaultRequestOnLoad()
    }
    
    private func defaultRequestOnLoad() {
        DispatchQueue.global().async {
            NetworkService.standard.getResponse { [weak self] (response, error) in
                guard let response = response else { self?.router.responseError(error: error!); return }
                
                self?.albumItems = response.items
                self?.view?.reloadData()
                self?.view?.updateState(state: .ready)
            }
        }
    }
    
    private func scRequestOnLoad() {
        Task {
            do {
                let albums = try await NetworkService.standard.scGetResponse()
                
                albumItems = albums.items
                view?.reloadData()
                view?.updateState(state: .ready)
            } catch {
                router.responseError(error: error)
            }
        }
    }
    
    func logout() {
        AuthService.standard.clearAccessToken()
        router.logoutAndPopToRoot()
    }
    
    func cellForItemAt(_ indexPath: IndexPath) -> Photo {
        return photos[indexPath.row]
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        router.showPhotoDetailsView(photo: photos[indexPath.row])
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection (section: Int) -> Int {
        return albumItems.count
    }
}
