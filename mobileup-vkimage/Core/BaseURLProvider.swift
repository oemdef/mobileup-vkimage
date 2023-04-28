//
//  BaseURLProvider.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

protocol IBaseURLProvider {
    var baseAuthURLString: String { get }
    var baseApiUrlString: String { get }
}

final class BaseURLProvider {
    var baseAuthUrlString = "https://oauth.vk.com"
    var baseApiUrlString = "https://api.vk.com"
}
