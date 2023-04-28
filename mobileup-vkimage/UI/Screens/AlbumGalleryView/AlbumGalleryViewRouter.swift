//
//  AlbumGalleryViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAlbumGalleryViewRouter: AnyObject {
    func showPhotoDetailsView()
}

final class AlbumGalleryViewRouter: IAlbumGalleryViewRouter {
    weak var transitionHandler: UIViewController?
    
    private let photoDetailsViewAssembly = PhotoDetailsViewAssembly()
   
    func showPhotoDetailsView() {
        let viewController = photoDetailsViewAssembly.assemble()
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}

