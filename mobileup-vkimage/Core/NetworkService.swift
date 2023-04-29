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
    
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    func getImageData(imageUrl: URL, completion: @escaping (Data?) -> Void) {
        request(url: imageUrl) { (data, error) in
            if let error = error {
                print("error while receiving data: \(error.localizedDescription)")
                completion(nil)
            }
            completion(data)
        }
    }
    
    func getResponse(response: @escaping (Album?, Error?) -> Void) {
        guard let url = constructRequestUrl() else { return }
        request(url: url) { (data, error) in
            if let error = error {
                print("error while receiving data: \(error.localizedDescription)")
                response(nil, error)
            }
            let decoded = self.decodeJSON(type: Response.self, from: data)
            response(decoded?.response, nil)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    func constructRequestUrl() -> URL? {
        let components = URLComponents(string: baseUrlProvider.baseApiUrlString)
        guard var components else { return nil }
        
        components.path = "/method/photos.get"
        
        guard let accessToken = AuthService.standard.loadAccessToken() else { return nil }
        let queryItems: [String : String] = [
            "owner_id" : "-128666765",
            "album_id" : "266310117",
            "access_token" : accessToken,
            "v" : "5.131"
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
