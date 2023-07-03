//
//  ImageCollectionViewCell.swift
//  Image Gallery
//
//  Created by DB-MM-011 on 29/06/23.
//
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with image: UIImage) {
        let resizedImage = image.resize(to: CGSize(width: 250, height: 250))
        imageView.image = resizedImage
    }
}
