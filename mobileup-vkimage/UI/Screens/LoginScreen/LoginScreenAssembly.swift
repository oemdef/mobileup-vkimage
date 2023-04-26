//
//  LoginScreenAssembly.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 26.04.2023.
//

import Foundation
import UIKit

protocol ILoginScreenAssembly: AnyObject {
    func assemble() -> UIViewController
}

final class LoginScreenAssembly: ILoginScreenAssembly {
    func assemble() -> UIViewController {
        let router = LoginScreenRouter()
        let presenter = LoginScreenPresenter(router: router)
        let viewController = LoginScreenViewController(presenter: presenter)
        
        presenter.view = viewController
        router.transitionHandler = viewController
        
        return viewController
    }
}
