//
//  LoginScreenRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 26.04.2023.
//

import Foundation
import UIKit

protocol ILoginScreenRouter: AnyObject {
    func showAuthWebView()
    func showAlbumGalleryView()
}

final class LoginScreenRouter: ILoginScreenRouter {
    weak var transitionHandler: UIViewController?
    
    private let authWebViewAssembly = AuthWebViewAssembly()
    private let albumGalleryViewAssembly = AlbumGalleryViewAssembly()
    
    func showAuthWebView() {
        guard let url = NetworkService.standard.constructAuthUrl() else { return }
        let viewController = authWebViewAssembly.assemble(with: url, delegate: transitionHandler as! ILoginScreenView)
        viewController.modalPresentationStyle = .automatic
        transitionHandler?.present(viewController, animated: true)
    }
    
    func showAlbumGalleryView() {
        let viewController = albumGalleryViewAssembly.assemble()
        transitionHandler?.navigationController?.setViewControllers([viewController], animated: true)
    }
}
