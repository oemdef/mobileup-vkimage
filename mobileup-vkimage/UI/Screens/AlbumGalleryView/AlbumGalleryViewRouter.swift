//
//  AlbumGalleryViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAlbumGalleryViewRouter: AnyObject {
}

final class AlbumGalleryViewRouter: IAlbumGalleryViewRouter {
    weak var transitionHandler: UIViewController?
   
}

