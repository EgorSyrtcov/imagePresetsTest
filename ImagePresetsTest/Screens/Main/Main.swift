//
//  Main.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import UIKit

final class Main: UIViewController {
    
    // MARK: - Properties
    var presenter: MainViewPresenterProtocol!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        presenter.fetchUser()
    }
    
    private func setupNavigationBar() {
        self.title = "Main image presents screen"
    }
}

extension Main: MainViewProtocol {
    func showSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.isHidden = false
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
}
