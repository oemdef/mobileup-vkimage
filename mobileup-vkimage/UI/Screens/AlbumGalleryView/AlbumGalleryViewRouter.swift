//
//  AlbumGalleryViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAlbumGalleryViewRouter: AnyObject {
    func showPhotoDetailsView(photo: AlbumItem)
    func logoutAndPopToRoot()
}

final class AlbumGalleryViewRouter: IAlbumGalleryViewRouter {
    weak var transitionHandler: UIViewController?
    
    private let photoDetailsViewAssembly = PhotoDetailsViewAssembly()
    private let loginScreenAssembly = LoginScreenAssembly()
   
    func showPhotoDetailsView(photo: AlbumItem) {
        let viewController = photoDetailsViewAssembly.assemble(photo: photo)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func logoutAndPopToRoot() {
        let viewController = loginScreenAssembly.assemble()
        transitionHandler?.navigationController?.setViewControllers([viewController], animated: true)
    }
}

