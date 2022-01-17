//
//  UserDetailPresenter.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 16.01.22.
//

import Foundation

protocol UserDetailProtocol: AnyObject {
    
}

protocol UserDetailPresenterProtocol: AnyObject {
    init(view: UserDetailProtocol, router: RouterProtocol, dependencies: Dependencies)
}

final class UserDetailPresenter: UserDetailPresenterProtocol {
  
    private weak var view: UserDetailProtocol?
    private var router: RouterProtocol?
    private var dependencies: Dependencies
    
    required init(view: UserDetailProtocol, router: RouterProtocol, dependencies: Dependencies) {
        self.view = view
        self.router = router
        self.dependencies = dependencies
    }
}
