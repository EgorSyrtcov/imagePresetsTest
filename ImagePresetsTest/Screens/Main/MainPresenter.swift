//
//  MainPresenter.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import Foundation
import UIKit

private let kScreenWidth = UIScreen.main.bounds.width

protocol MainViewProtocol: AnyObject {
    func reloadCollection()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies)
    
    func fetchUser()
    func numberOfRowsInSection() -> Int
    func getUser(by indexPath: IndexPath) -> User?
    func pushUserDetailScreen(_ user: User?, point: UserDetailEntryPoint)
    func infinityScrollView(scrollView: UIScrollView) -> Int
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
    
    func infinityScrollView(scrollView: UIScrollView) -> Int {
        
        var currentPage = 0
        
        /// When the UIScrollView slides to the first stop, change the offset of the UIScrollView
        if (scrollView.contentOffset.x == 0) {
            scrollView.contentOffset = CGPoint(x: CGFloat(self.allUsers.count) * kScreenWidth,y: 0)
            currentPage = self.allUsers.count
            /// When the UIScrollView slides to the last stop, the offset of the UIScrollView is changed
        } else if (scrollView.contentOffset.x == CGFloat(self.allUsers.count + 1) * kScreenWidth) {
            scrollView.contentOffset = CGPoint(x: kScreenWidth,y: 0)
            currentPage = 0
        } else {
            currentPage = Int(scrollView.contentOffset.x / kScreenWidth) - 1
        }
        return currentPage
    }
}

extension MainPresenter {
    
    func numberOfRowsInSection() -> Int {
        return allUsers.count
    }
    
    func getUser(by indexPath: IndexPath) -> User? {
        
        var user: User?
        
        if (indexPath.item == 0) {
            user = allUsers.last
            
        } else if (indexPath.item == allUsers.count + 1) {
            user = allUsers.first
        } else {
            user = allUsers[indexPath.item - 1]
        }
        
        return user
    }
}

extension MainPresenter {
    
    func pushUserDetailScreen(_ user: User?, point: UserDetailEntryPoint) {
        guard let user = user else { return }
        router?.pushUserDetailScreen(user: user, point: point)
    }
    
    
}
