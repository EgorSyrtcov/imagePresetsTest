//
//  UserDetail.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 16.01.22.
//

import UIKit
import WebKit

final class UserDetail: UIViewController {
    
    var presenter: UserDetailPresenterProtocol!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var webView: WKWebView!
    
    private let user: User
    private let point: UserDetailEntryPoint
    
    init(user: User, point: UserDetailEntryPoint) {
        self.user = user
        self.point = point
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        startUrl()
        setupWebView()
    }
    
    private func setupNavigationBar() {
        self.title = point.title
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
    }
    
    private func startUrl() {
        switch point {
        case .author:
            guard let url = URL(string: user.userUrl) else { return }
            webView.load(URLRequest(url: url))
        case .photo:
            guard let url = URL(string: user.photoUrl) else { return }
            webView.load(URLRequest(url: url))
        }
    }
}

extension UserDetail: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

extension UserDetail: UserDetailProtocol {
    
}
