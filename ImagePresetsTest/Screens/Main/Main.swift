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
    
    private weak var timer : Timer?
    private let timeInterval: TimeInterval = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        presenter.fetchUser()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        starTimer()
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
            self?.collectionView.reloadData()
            self?.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)
            self?.updatePageControlNumberOfPage()
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
        
        return presenter.numberOfRowsInSection() == 0
        ? 0
        : presenter.numberOfRowsInSection() + 2
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
        let currentPage = presenter.infinityScrollView(scrollView: scrollView)
        pageControl.currentPage = currentPage
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
            height: collectionView.frame.height)
    }
}

extension Main: UserCellDelegate {
    
    func didTapAuthorButton(user: User?) {
        stopTimer()
        presenter.pushUserDetailScreen(user, point: .author)
    }
    
    func didTapPhotoButton(user: User?) {
        stopTimer()
        presenter.pushUserDetailScreen(user, point: .photo)
    }
}

extension Main {
    ///  Open timer
    private func starTimer () {
        let timer = Timer.init(timeInterval: timeInterval, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        //  This sentence involves knowledge of Runloop and main threads, and other UI operations cannot be performed on the interface.
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        
        self.timer = timer
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc func nextPage() {
        //  If the last one arrives, it becomes fourth.
        if collectionView.contentOffset.x == CGFloat( self.presenter.numberOfRowsInSection()) * self.collectionView.bounds.width {
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)
        }else {
            //  Every one second, ContentOffset.x adds a Cell width
            self.collectionView.contentOffset.x += self.collectionView.bounds.size.width
        }
        let currentPage = presenter.infinityScrollView(scrollView: collectionView)
        pageControl.currentPage = currentPage
    }
    
    ///  Cance the timer when the CollectionView starts dragging
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    ///  When the user stops dragging, turn on the timer
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        starTimer()
    }
}
