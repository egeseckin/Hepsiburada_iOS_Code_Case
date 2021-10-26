//
//  ResultViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit

var iTunesURL = "https://itunes.apple.com/search?"

class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
        
    func fetchTerm(term: String, entity: String ){
        let urlString = "\(iTunesURL)term=\(term)&entity=\(entity)"
            
        iTunesURL = urlString
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iTunesCollectionViewCell", for: indexPath) as! iTunesCollectionViewCell
        
        if let url = URL(string: iTunesURL){
            //Create URL Session
            let session = URLSession(configuration: .default)
            
            //Give a task to the session
            //Closure
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(iTunesApiData.self, from: safeData)
                        if (decodedData.resultCount != 0){
                            cell.setup(with: decodedData)
                            
                        }
                        
                    }catch{
                        print(error)
                    }
                }
            }
            
            //Start the task
            task.resume()
        }
        
        
        return cell
    }
    

}

