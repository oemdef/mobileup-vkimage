//
//  PhotoDetailsViewAssembly.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IPhotoDetailsViewAssembly: AnyObject {
    func assemble(photo: Photo) -> UIViewController
}

final class PhotoDetailsViewAssembly: IPhotoDetailsViewAssembly {
    func assemble(photo: Photo) -> UIViewController {
        let router = PhotoDetailsViewRouter()
        let presenter = PhotoDetailsViewPresenter(router: router)
        let viewController = PhotoDetailsViewController(presenter: presenter, photo: photo)
        
        presenter.view = viewController
        router.transitionHandler = viewController
        
        return viewController
    }
}
