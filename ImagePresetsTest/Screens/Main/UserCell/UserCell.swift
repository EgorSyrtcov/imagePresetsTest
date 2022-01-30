//
//  UserCell.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 15.01.22.
//

import UIKit

protocol UserCellDelegate: AnyObject {
    func didTapAuthorButton(user: User?)
    func didTapPhotoButton(user: User?)
}


final class UserCell: UICollectionViewCell {
    
    weak var delegate: UserCellDelegate?
    private var user: User?
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mainCellView: UIView!
    @IBOutlet weak var containerImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUser(_ user: User?) {
        self.user = user
        guard let user = user else { return }
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
        setupContainerImageView()
    }
    
}

extension UserCell {
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
    }
    
    private func setupContainerImageView() {
        containerImageView.layer.masksToBounds = false
        containerImageView.layer.shadowColor = UIColor.black.cgColor
        containerImageView.layer.shadowOffset = .zero
        containerImageView.layer.shadowRadius = 5
        containerImageView.layer.shadowOpacity = 0.35
        containerImageView.layer.shouldRasterize = true
        containerImageView.layer.cornerRadius = 20
    }
}
