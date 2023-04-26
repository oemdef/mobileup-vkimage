//
//  LoginScreenPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 26.04.2023.
//

import Foundation

protocol ILoginScreenPresenter: AnyObject {
    
}

final class LoginScreenPresenter: ILoginScreenPresenter {
    weak var view: ILoginScreenView?
    private let router: ILoginScreenRouter
    
    init(router: ILoginScreenRouter) {
        self.router = router
    }
}
