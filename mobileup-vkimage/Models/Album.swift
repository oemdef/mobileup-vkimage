//
//  Album.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation

struct Response: Decodable {
    let response: Album
}

struct Album: Decodable {
    let items: [AlbumItem]
}

struct AlbumItem: Decodable {
    let date: Double
    let sizes: [PhotoMetadata]
}

struct PhotoMetadata: Decodable {
    let url: String
    var type: String
}

struct Photo {
    let date: String
    let photoUrl: URL
}
