//
//  collectionViewProtocol.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 31.10.2021.
//

import UIKit


extension ResultViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    //if input inside searchbar changes (dynamically) it comes here
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchApi()
    }
    
    
    // MARK: Number Of Items
    //How many items should be displayed
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.actIN.stopAnimating()
        if(dataresult.count > 0 ){
            if(dataresult.count < cellNumber){
                return dataresult.count
            }
            else{
                return cellNumber
            }
        }
        return 0
        
    }
    
    
    
    // MARK: Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //Increments the number of cells on the page when it comes to end of page
        if indexPath.row == cellNumber-1   {
            self.actIN.startAnimating()
            cellNumber = cellNumber + 20
            collectionView.reloadData()
        }
    }
    
}
