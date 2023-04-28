//
//  NetworkService.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 29.04.2023.
//

import Foundation

final class NetworkService {
    
    static let standard = NetworkService()
    private init() {}
    
    private let baseUrlProvider = BaseURLProvider()
    
    func constructRequestUrl() -> URL? {
        let components = URLComponents(string: baseUrlProvider.baseApiUrlString)
        guard var components else { return nil }
        
        components.path = "/method/photos.get"
        
        guard let accessToken = AuthService.standard.loadAccessToken() else { return nil }
        let queryItems: [String : String] = [
            "owner_id" : "-128666765",
            "album_id" : "266310117",
            "access_token" : accessToken
        ]
        components.queryItems = queryItems.map({ URLQueryItem(name: $0.key, value: $0.value )})
        
        guard let url = components.url else { return nil }
        
        return url
    }
    
    func constructAuthUrl() -> URL? {
        let components = URLComponents(string: baseUrlProvider.baseAuthUrlString)
        guard var components else { return nil }
        
        components.path = "/authorize"
        let queryItems: [String : String] = [
            "client_id" : "51627350",
            "redirect_uri" : "https://oauth.vk.com/blank.html",
            "display" : "mobile",
            "response_type" : "token"
        ]
        components.queryItems = queryItems.map({ URLQueryItem(name: $0.key, value: $0.value )})
        
        guard let url = components.url else { return nil }
        
        return url
    }
}
