//
//  UserCell.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 15.01.22.
//

import UIKit

final class UserCell: UICollectionViewCell {
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mainCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUser(_ user: User) {
        name.text = ("Author: \(user.userName)")
        guard let urlString = user.imageURL else { return }
        imageView.loadImageUsingCache(withUrl: urlString)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupImageView()
    }
    
}

extension UserCell {
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
    }
}
