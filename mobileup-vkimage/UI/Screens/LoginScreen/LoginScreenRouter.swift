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
    func showAuthNotFinished()
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
    
    func showAuthNotFinished() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Авторизация не была завершена", message: "Вы не закончили авторизацию через OAuth в приложении. Она нужна для его корректной работы.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "ОК", style: .default)
            alertController.addAction(actionOK)
            self.transitionHandler?.present(alertController, animated: true, completion: nil)
        }
    }
}
