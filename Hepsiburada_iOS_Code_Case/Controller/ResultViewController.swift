//
//  ResultViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit


class ResultViewController: iTunesApiManager, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dataresult = [iTunesApiData]()

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "iTunesCollectionViewCell")
        let iTunesURL = "https://itunes.apple.com/search?"
        
        func fetchTerm(term: String, entity: String ){
            let urlString = "\(iTunesURL)term=\(term)&entity=\(entity)"
            performRequest(urlString: urlString)
        }
        
        func performRequest(urlString: String){
            
            //Create URL
            
            let url = URL(string: urlString)
            //Create URL Session
            let session = URLSession(configuration: .default)
            
            //Give a task to the session
            //Closure
            let task =  session.dataTask(with: url!) { data, response, error in
                if error != nil {
                    print(error!)
                }
                else{
                    do{
                        let datadecoded = try JSONDecoder().decode(iTunesApiData.self, from: data!)
                        self.dataresult = [datadecoded]
                        
                    }catch{
                        print(error)
                    }
                    
                }
            }
            
            //Start the task
            task.resume()
            
        }
    }
    
}


extension ResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iTunesCollectionViewCell", for: indexPath) as! iTunesCollectionViewCell
        
        cell.nameLabel.text =  "Name: " + dataresult[0].results[indexPath.row].collectionName
        
        cell.priceLabel.text = "Price: " + String(dataresult[0].results[indexPath.row].collectionPrice) + "$"
        
        let date = dataresult[0].results[indexPath.row].releaseDate.components(separatedBy: "T")
        cell.dateLabel.text = "Date: " + date[0]
        
        return cell
    }
}
