//
//  MainPresenter.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import Foundation

protocol MainViewProtocol: AnyObject {}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies)
    
    func fetchImages()
}

final class MainPresenter: MainViewPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    private var router: RouterProtocol?
    private var dependencies: Dependencies
    
    required init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies) {
        self.view = view
        self.router = router
        self.dependencies = dependencies
    }
}

extension MainPresenter {
    
    func fetchImages() {
        
    }
}
