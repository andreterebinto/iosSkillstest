//
//  fotoViewController.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 04/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class fotoViewController: UIViewController{
    
    @IBOutlet weak var tblFotos: UITableView!
    var fotos = [[String:String]]()
    let URL_JSON = "https://jsonplaceholder.typicode.com/photos";
    
    //A string array to save all the names
    var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonFromUrl();
        tblFotos.delegate = self
        tblFotos.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getJsonFromUrl(){
        guard let url = URL(string: URL_JSON) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                
                let jsonResponse = try JSONSerialization.jsonObject(with:dataResponse, options: [])
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                
                for dic in jsonArray{
                    self.fotos.append(["thumbnailUrl": (dic["thumbnailUrl"] as? String)!, "title": (dic["title"] as? String)! ])
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
            DispatchQueue.main.async {
                
                self.tblFotos.reloadData()
                
            }
           
            
        }
        task.resume()
        
        self.tblFotos.reloadData()
        
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

