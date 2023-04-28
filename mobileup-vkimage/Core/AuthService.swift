//
//  AuthService.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

final class AuthService {
    
    static let standard = AuthService()
    private init() {}
    
    func saveAccessToken(token: String, expiresIn: Double) {
        let expirationDate = Date.now + expiresIn
        UserDefaults.standard.set(expirationDate.timeIntervalSince1970, forKey: String.userDefaultsExpKey)
        let tokenData = Data(token.utf8)
        KeychainService.standard.save(tokenData, service: String.kcServiceKey, account: String.kcAccountKey)
    }
    
    func loadAccessToken() -> String? {
        let tokenData = KeychainService.standard.read(service: String.kcServiceKey, account: String.kcAccountKey)
        guard let tokenData else { return nil }
        let accessToken = String(data: tokenData, encoding: .utf8)
        return accessToken
    }
    
    func isLastTokenValid() -> Bool {
        let expirationDate = UserDefaults.standard.double(forKey: String.userDefaultsExpKey)
        return Date.now.timeIntervalSince1970 > expirationDate ? false : true
    }
}

private extension String {
    static let kcServiceKey = "access-token"
    static let kcAccountKey = "vk"
    static let userDefaultsExpKey = "lastValidTokenExpiration"
}
