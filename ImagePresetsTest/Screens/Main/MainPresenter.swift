//
//  MainPresenter.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func reloadCollection()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies)
    
    func fetchUser()
    func numberOfRowsInSection() -> Int
    func getUser(by indexPath: IndexPath) -> User
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
        dependencies.apiService.fetchUsers { [weak self] users in
            let sorted = users.sorted(by: { $0.userName < $1.userName })
                self?.allUsers = sorted
                self?.view?.reloadCollection()
        }
    }

}

extension MainPresenter {
    
    func numberOfRowsInSection() -> Int {
        return allUsers.count
    }
    
    func getUser(by indexPath: IndexPath) -> User {
        return allUsers[indexPath.item]
    }
}
