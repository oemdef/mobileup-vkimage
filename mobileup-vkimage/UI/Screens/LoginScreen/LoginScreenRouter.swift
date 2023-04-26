//
//  LoginScreenRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 26.04.2023.
//

import Foundation
import UIKit

protocol ILoginScreenRouter: AnyObject {
    
}

final class LoginScreenRouter: ILoginScreenRouter {
    weak var transitionHandler: UIViewController?
}
