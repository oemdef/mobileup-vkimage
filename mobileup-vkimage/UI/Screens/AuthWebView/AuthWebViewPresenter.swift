//
//  AuthWebViewPresenter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

protocol IAuthWebViewPresenter: AnyObject {
    func viewDidLoad()
    func failedToLoad()
    func handleCallbackUrl(url: URL)
}

final class AuthWebViewPresenter: IAuthWebViewPresenter {
    
    private let router: IAuthWebViewRouter
    
    init(router: IAuthWebViewRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        // TODO: Implementation
    }
    
    func failedToLoad() {
        // TODO: Implementation
    }
    
    func handleCallbackUrl(url: URL) {
        let urlString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
        let oauthToken = NSURLComponents(string: urlString)?.queryItems?.filter({$0.name == "access_token"}).first?.value
        
        if let oauthToken {
            // TODO: Save valid token to Keychain
            gotValidToken()
        }
    }
    
    private func gotValidToken() {
        router.dismiss()
    }
}
