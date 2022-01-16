//
//  UICollectionView.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

extension UICollectionView {
    
    func registerClassForCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    func registerNibForCell<T: UICollectionViewCell>(_ cell: T.Type) {
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for index: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: index) as! T
    }
    
}
