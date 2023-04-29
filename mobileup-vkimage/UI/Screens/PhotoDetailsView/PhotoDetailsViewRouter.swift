//
//  PhotoDetailsViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IPhotoDetailsViewRouter: AnyObject {
    func showShareSheet(image: UIImage)
}

final class PhotoDetailsViewRouter: IPhotoDetailsViewRouter {
    weak var transitionHandler: UIViewController?
    
    func showShareSheet(image: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [
            image
        ], applicationActivities: nil)
        transitionHandler?.present(activityVC, animated: true)
    }
}
