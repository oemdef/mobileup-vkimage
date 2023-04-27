//
//  AuthWebViewAssembly.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAuthWebViewAssembly: AnyObject {
    func assemble(with url: URL) -> UIViewController
}

final class AuthWebViewAssembly: IAuthWebViewAssembly {
    func assemble(with url: URL) -> UIViewController {

        let router = AuthWebViewRouter()
        let presenter = AuthWebViewPresenter(router: router)
        
        let viewController = AuthWebViewController(presenter: presenter, url: url)

        router.transitionHandler = viewController
        return viewController
    }
}
