//
//  ViewController.swift
//  PracticeNov30Cv
//
//  Created by Muralidhar reddy Kakanuru on 11/30/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var images : [UIImage] = []
    
    private var collectionview : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        return collectionView
        
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Library"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0...25 {
            images.append(UIImage(named: "house1")!)
            images.append(UIImage(named: "house2")!)
            images.append(UIImage(named: "house3")!)
            images.append(UIImage(named: "house4")!)
            images.append(UIImage(named: "house5")!)
        }
        self.view.backgroundColor = .blue
        setUi()
        
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
    }
    
    func setUi() {
        self.view.addSubview(collectionview)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
    }

}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else {
            fatalError("failed to dequeue cell")}
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width / 3) - 1.34
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
    


