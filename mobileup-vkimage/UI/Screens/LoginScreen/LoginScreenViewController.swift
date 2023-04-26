//
//  LoginScreenViewController.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 26.04.2023.
//

import Foundation
import UIKit

protocol ILoginScreenView: AnyObject {
    
}

final class LoginScreenViewController: UIViewController, ILoginScreenView {
    private let presenter: ILoginScreenPresenter

    init(presenter: ILoginScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
