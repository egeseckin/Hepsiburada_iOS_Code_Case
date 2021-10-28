//
//  ResultViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit

var iTunesURL = "https://itunes.apple.com/search?"


class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dataresult = [iTunesApiData]()
        
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "iTunesCollectionViewCell")
        
        let url = URL(string: iTunesURL)
           //Create URL Session
            let session = URLSession(configuration: .default)
           
           //Give a task to the session
           //Closure
            let task = session.dataTask(with: url!) { data, response, error in
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
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                
                               
                        }
                       
                }
            }
        //Start the task
        task.resume()


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
         
        DispatchQueue.main.asyncAfter(deadline: .now()) {
             cell.setup(with: self.dataresult)
        }
         
        return cell
    }
}



