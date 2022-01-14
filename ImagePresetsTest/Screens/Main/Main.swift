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
    }
    
    private func setupNavigationBar() {
        self.title = "Main image presents screen"
    }
}

extension Main: MainViewProtocol {}
