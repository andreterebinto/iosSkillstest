//
//  listaUsuarioViewController.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 03/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class listaUsuarioViewController: UIViewController{
    
    @IBOutlet weak var tblUsuarios: UITableView!
    var usuarios = [[String:String]]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblUsuarios.delegate = self
        tblUsuarios.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    @available(iOS 10.0, *)
    func listaUsuarios(){
    
   
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                usuarios.append(["nome": data.value(forKey: "nome") as! String, "email": data.value(forKey: "email") as! String, "senha": data.value(forKey: "senha") as! String ])
            }
            
           tblUsuarios.reloadData()
            
        } catch {
            
            print("Falha")
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.usuarios = []
        if #available(iOS 10.0, *) {
            self.listaUsuarios()
        } else {
            // Fallback on earlier versions
        }
    }
}
