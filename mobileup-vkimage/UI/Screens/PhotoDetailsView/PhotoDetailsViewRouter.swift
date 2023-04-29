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
        
        activityVC.completionWithItemsHandler = {(UIActivityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Успешное сохранение", message: "Фотография успешно сохранена в вашу Медиатеку", preferredStyle: .alert)
                    let actionOK = UIAlertAction(title: "Здорово", style: .default)
                    alertController.addAction(actionOK)
                    self.transitionHandler?.present(alertController, animated: true, completion: nil)
                }
            }
            if let error {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Не удалось сохранить фотографию", message: "Ошибка: \(error.localizedDescription)", preferredStyle: .alert)
                    let actionOK = UIAlertAction(title: "ОК", style: .default)
                    alertController.addAction(actionOK)
                    self.transitionHandler?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.transitionHandler?.present(activityVC, animated: true)
        }
    }
}
