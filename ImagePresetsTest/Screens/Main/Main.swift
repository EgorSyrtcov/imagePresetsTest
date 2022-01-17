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

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        presenter.fetchUser()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        self.title = "Main image presents"
    }
    
    private func setupCollectionView() {
        collectionView.registerNibForCell(UserCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension Main: MainViewProtocol {
    
    func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.updatePageControlNumberOfPage()
            self?.collectionView.reloadData()
        }
    }
    
    private func updatePageControlNumberOfPage() {
        pageControl.numberOfPages = presenter.numberOfRowsInSection()
    }
}

extension Main: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: UserCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        let user = presenter.getUser(by: indexPath)
        cell.setupUser(user)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension Main: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height - 10)
    }
}

extension Main: UserCellDelegate {
    func didTapAuthorButton(user: User?) {
        presenter.pushUserDetailScreen(user, point: .author)
    }
    
    func didTapPhotoButton(user: User?) {
        presenter.pushUserDetailScreen(user, point: .photo)
    }
}
