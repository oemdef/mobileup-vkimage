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
        // TODO: Move this out of here
        let strLink: String = "https://oauth.vk.com/authorize?client_id=51627350&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&response_type=token"
        guard let url = URL(string: strLink) else {
            print("Invalid link")
            return
        }
        
        let viewController = authWebViewAssembly.assemble(with: url, delegate: transitionHandler as! ILoginScreenView)
        viewController.modalPresentationStyle = .automatic
        transitionHandler?.present(viewController, animated: true)
    }
    
    func showAlbumGalleryView() {
        let viewController = albumGalleryViewAssembly.assemble()
        transitionHandler?.navigationController?.setViewControllers([viewController], animated: true)
    }
}
