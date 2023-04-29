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
    func authWebViewGotDismissed()
}

final class LoginScreenPresenter: ILoginScreenPresenter {
    weak var view: ILoginScreenView?
    private let router: ILoginScreenRouter
    
    init(router: ILoginScreenRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        if AuthService.standard.isLastTokenValid() {
            authWebViewGotDismissed()
        }
    }
    
    func loginButtonTapped() {
        router.showAuthWebView()
    }
    
    func authWebViewGotDismissed() {
        if AuthService.standard.isLastTokenValid() {
            router.showAlbumGalleryView()
        } else {
            router.showAuthNotFinished()
        }
    }
}
