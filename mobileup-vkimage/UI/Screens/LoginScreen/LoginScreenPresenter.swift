//
//  LoginScreenPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 26.04.2023.
//

import Foundation

protocol ILoginScreenPresenter: AnyObject {
    func viewDidLoad()
    func loginButtonTapped()
}

final class LoginScreenPresenter: ILoginScreenPresenter {
    weak var view: ILoginScreenView?
    private let router: ILoginScreenRouter
    
    init(router: ILoginScreenRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        // TODO: Implementation
    }
    
    func loginButtonTapped() {
        router.showAuthWebView()
    }
}
