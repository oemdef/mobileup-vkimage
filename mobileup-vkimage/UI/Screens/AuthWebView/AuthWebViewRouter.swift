//
//  AuthWebViewRouter.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 28.04.2023.
//

import Foundation
import UIKit

protocol IAuthWebViewRouter: AnyObject {
    func dismiss()
    func failedToLoad(error: Error)
    func invalidToken()
}

final class AuthWebViewRouter: IAuthWebViewRouter {
    weak var transitionHandler: UIViewController?
    
    func dismiss() {
        transitionHandler?.presentingViewController?.dismiss(animated: true)
    }
    
    func failedToLoad(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Не удалось отобразить страницу", message: "Загрузка страницы авторизации не удалась. Проверьте подключение к интернету. Ошибка: \(error.localizedDescription)", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Попробовать снова", style: .default)
            alertController.addAction(actionOK)
            self.transitionHandler?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func invalidToken() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка API", message: "Авторизация не удалась. Операция получения токена от VK OAuth API закончилась с ошибкой.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Попробовать снова", style: .default)
            alertController.addAction(actionOK)
            self.transitionHandler?.present(alertController, animated: true, completion: nil)
        }
    }
}
