//
//  ResultViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit


class ResultViewController: iTunesApiManager, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "iTunesCollectionViewCell")

    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iTunesCollectionViewCell", for: indexPath) as! iTunesCollectionViewCell
         DispatchQueue.main.asyncAfter(deadline: .now()) {
             cell.setup(with: dataresult)
         }
        return cell
    }
}



