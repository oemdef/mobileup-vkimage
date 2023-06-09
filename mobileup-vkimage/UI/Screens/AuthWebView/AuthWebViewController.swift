//
//  AuthWebViewController.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 27.04.2023.
//

import Foundation
import UIKit
import WebKit

protocol IAuthWebView: AnyObject {
}

final class AuthWebViewController: UIViewController, IAuthWebView {
    private let presenter: IAuthWebViewPresenter
    private var url: URL
    
    weak var delegate: ILoginScreenView?
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let webView = WKWebView(frame: view.frame, configuration: configuration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        return webView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    init(presenter: IAuthWebViewPresenter, url: URL, delegate: ILoginScreenView) {
        self.presenter = presenter
        self.url = url
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        
        addSubviews()
        setupConstraints()
        
        let req = URLRequest(url: url)
        activityIndicator.startAnimating()
        webView.load(req)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.presentedDidDismiss()
    }
    
    private func addSubviews() {
        webView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
    }
}

extension AuthWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        guard let callbackURL = webView.url else { return }
        if callbackURL.absoluteString.hasPrefix("https://oauth.vk.com/blank.html") {
            presenter.handleCallbackUrl(url: callbackURL)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        presenter.failedToLoad(with: error)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        presenter.failedToLoad(with: error)
    }
}
