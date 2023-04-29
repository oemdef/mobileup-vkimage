//
//  AlbumGalleryViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAlbumGalleryViewRouter: AnyObject {
    func showPhotoDetailsView(photo: Photo)
    func responseError(error: Error)
    func logoutAndPopToRoot()
}

final class AlbumGalleryViewRouter: IAlbumGalleryViewRouter {
    weak var transitionHandler: UIViewController?
    
    private let photoDetailsViewAssembly = PhotoDetailsViewAssembly()
    private let loginScreenAssembly = LoginScreenAssembly()
   
    func showPhotoDetailsView(photo: Photo) {
        let viewController = photoDetailsViewAssembly.assemble(photo: photo)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func responseError(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Неудачный запрос к API", message: "Проверьте подключение к интернету. Ошибка: \(error.localizedDescription)", preferredStyle: .alert)
            let actionRetry = UIAlertAction(title: "Попробовать снова", style: .default) { (retry) in
                self.transitionHandler?.viewDidLoad()
            }
            alertController.addAction(actionRetry)
            self.transitionHandler?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func logoutAndPopToRoot() {
        let viewController = loginScreenAssembly.assemble()
        transitionHandler?.navigationController?.setViewControllers([viewController], animated: true)
    }
}

