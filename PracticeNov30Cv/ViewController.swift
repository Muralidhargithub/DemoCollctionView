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
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
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
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else {
            fatalError("failed to dequeue cell")
        }
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
    
    // Setup header for the collection view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderCollectionReusableView
            header.setupHeader()
            return header
        }
        return UICollectionReusableView()
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    // Define size for the items in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width / 3) - 1.34
        return CGSize(width: size, height: size)
    }
    
    // Define the minimum spacing between lines and items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    // Define size for the header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120) // Adjust height as needed
    }
}

class HeaderCollectionReusableView: UICollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Library"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        return button
    }()
    
    // Setup the header UI elements
    func setupHeader() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(searchButton)
        addSubview(selectButton)
        addSubview(profileButton)
        
        // Set up the constraints for each element
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            selectButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -16),
            selectButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: selectButton.leadingAnchor, constant: -16),
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
    }
}
