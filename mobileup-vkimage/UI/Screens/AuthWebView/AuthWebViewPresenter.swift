//
//  AuthWebViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAuthWebViewPresenter: AnyObject {
    func viewDidLoad()
    func failedToLoad(with error: Error)
    func handleCallbackUrl(url: URL)
}

final class AuthWebViewPresenter: IAuthWebViewPresenter {
    weak var view: IAuthWebView?
    private let router: IAuthWebViewRouter
    
    init(router: IAuthWebViewRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        // TODO: Implementation
    }
    
    func failedToLoad(with error: Error) {
        router.failedToLoad(error: error)
    }
    
    func handleCallbackUrl(url: URL) {
        let urlString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
        let queryItems = NSURLComponents(string: urlString)?.queryItems
        
        let oauthToken = queryItems?.filter({$0.name == "access_token"}).first?.value
        let expiresInString = queryItems?.filter({$0.name == "expires_in"}).first?.value
        
        if let oauthToken, let expiresInString {
            if let expiresIn = Double(expiresInString) {
                AuthService.standard.saveAccessToken(token: oauthToken, expiresIn: expiresIn)
                gotValidToken()
            } else {
                gotInvalidToken()
            }
        } else {
            gotInvalidToken()
        }
    }
    
    private func gotValidToken() {
        router.dismiss()
    }
    
    private func gotInvalidToken() {
        router.invalidToken()
        router.dismiss()
    }
}
