//
//  AuthWebViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAuthWebViewRouter: AnyObject {
    func dismiss()
}

final class AuthWebViewRouter: IAuthWebViewRouter {
    weak var transitionHandler: UIViewController?
    
    func dismiss() {
        transitionHandler?.presentingViewController?.dismiss(animated: true)
    }
}
