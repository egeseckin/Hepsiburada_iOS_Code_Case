//
//  iTunesApiManager.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import Foundation

struct iTunesApiManager{
    
    let iTunesURL = "https://itunes.apple.com/search?"
    
    func fetchTerm(term: String, entity: String ){
        let urlString = "\(iTunesURL)term=\(term)&entity=\(entity)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        //Create URL
        
        if let url = URL(string: urlString){
            //Create URL Session
            let session = URLSession(configuration: .default)
            
            //Give a task to the session
            //Closure
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data{
                    self.parseJSON(iTunesData: safeData)
                }
            }
            
            //Start the task
            task.resume()
        }
    }
    func parseJSON(iTunesData: Data ){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(iTunesApiData.self, from: iTunesData)
            print(decodedData.results[0].collectionPrice)
        }catch{
            print(error)
        }
        
    }
}
