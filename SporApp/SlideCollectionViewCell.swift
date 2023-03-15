//
//  SlideCollectionViewCell.swift
//  SporApp
//
//  Created by Erkan on 12.03.2023.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: SlideCollectionViewCell.self)
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    func setup(_ slide: FirstScreenSlide){
       // label.text = slide.description
        imageView.image = slide.image
    }
    
}
