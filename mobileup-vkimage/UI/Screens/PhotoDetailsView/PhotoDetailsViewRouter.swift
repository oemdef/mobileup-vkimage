//
//  PhotoDetailsViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IPhotoDetailsViewRouter: AnyObject {
    func goBack()
}

final class PhotoDetailsViewRouter: IPhotoDetailsViewRouter {
    weak var transitionHandler: UIViewController?
   
    func goBack() {
        transitionHandler?.presentingViewController?.navigationController?.popViewController(animated: true)
    }
}
