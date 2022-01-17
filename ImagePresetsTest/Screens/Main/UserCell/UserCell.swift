//
//  UserCell.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 15.01.22.
//

import UIKit

protocol UserCellDelegate {
    func didTapAuthorButton(user: User?)
    func didTapPhotoButton(user: User?)
}


final class UserCell: UICollectionViewCell {
    
    var delegate: UserCellDelegate?
    private var user: User?
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mainCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUser(_ user: User) {
        self.user = user
        name.text = ("Author: \(user.userName)")
        
        guard let urlString = user.imageURL else { return }
        imageView.loadImageUsingCache(withUrl: urlString)
    }
    
    @IBAction func authorTouchAction(_ sender: UIButton) {
        delegate?.didTapAuthorButton(user: user)
    }
    
    @IBAction func photoTouchAction(_ sender: UIButton) {
        delegate?.didTapPhotoButton(user: user)
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
