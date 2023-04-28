//
//  AlbumGalleryViewAssembly.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAlbumGalleryViewAssembly: AnyObject {
    func assemble() -> UIViewController
}

final class AlbumGalleryViewAssembly: IAlbumGalleryViewAssembly {
    func assemble() -> UIViewController {
        let router = AlbumGalleryViewRouter()
        let presenter = AlbumGalleryViewPresenter(router: router)
        let viewController = AlbumGalleryViewController(presenter: presenter)
        
        presenter.view = viewController
        router.transitionHandler = viewController
        
        return viewController
    }
}
