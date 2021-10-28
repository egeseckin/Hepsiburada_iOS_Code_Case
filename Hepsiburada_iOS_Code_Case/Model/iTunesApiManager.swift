//
//  iTunesApiManager.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import Foundation
import UIKit


class iTunesApiManager: UIViewController{
    
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
                       // dataresult = [datadecoded]
                    
                }catch{
                    print(error)
                }
                
            }
        }
        
        //Start the task
        task.resume()
        
    }
    
}
