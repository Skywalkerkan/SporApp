//
//  ViewController.swift
//  SporApp
//
//  Created by Erkan on 12.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var slides: [FirstScreenSlide] = []
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
            
        let image = UIImage(imageLiteralResourceName: "fitness1")
        let image2 = UIImage(imageLiteralResourceName: "fitness2")
        let image3 = UIImage(imageLiteralResourceName: "fitness3")

        
        
        slides = [
            FirstScreenSlide(name: "hebeleGübsdf", description: "asdfdsfdsafadsfasdf", image: image),
            FirstScreenSlide(name: "hebeleGübsdf", description: "hebeleGüsdafasdbsdf", image: image2),
            FirstScreenSlide(name: "hebeleGübsdf", description: "hebeleGsdafasdfübsdf", image: image3)
        ]
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func nextBtnClicked(_ sender: Any) {
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.identifier, for: indexPath) as! SlideCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    

}

