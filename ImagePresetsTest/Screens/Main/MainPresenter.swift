//
//  MainPresenter.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func showSpinner()
    func hideSpinner()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies)
    
    func fetchUser()
}

final class MainPresenter: MainViewPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    private var router: RouterProtocol?
    private var dependencies: Dependencies
    
    private var allUsers = [User]()
    
    required init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies) {
        self.view = view
        self.router = router
        self.dependencies = dependencies
    }
}

extension MainPresenter {
    
    func fetchUser() {
        view?.showSpinner()
        dependencies.apiService.fetchUsers { [weak self] users in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self?.allUsers = users
                self?.view?.hideSpinner()
            }
        }
    }

}
