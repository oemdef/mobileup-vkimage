//
//  LoginScreenViewController.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 26.04.2023.
//

import Foundation
import UIKit
import AuthenticationServices

protocol ILoginScreenView: AnyObject {
}

final class LoginScreenViewController: UIViewController, ILoginScreenView {
    private let presenter: ILoginScreenPresenter
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "MobileUp Gallery"
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 44, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = .label
        loginButton.layer.cornerRadius = 12
        loginButton.layer.cornerCurve = .continuous
        
        loginButton.setTitle("Вход через VK", for: .normal)
        loginButton.setTitleColor(.systemBackground, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    init(presenter: ILoginScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        addSubviews()
        setupConstraints()
        
        presenter.viewDidLoad()
    }
    
    @objc private func loginButtonTapped() {
        presenter.loginButtonTapped()
    }
                                                    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.widthAnchor.constraint(equalToConstant: 227)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14)
        ])
    }
}

