//
//  listaUsuarioTableView.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 03/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension listaUsuarioViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.usuarios = []
        tblUsuarios.reloadData()
        
        if (searchText == ""){
            self.listaUsuarios()
        }
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "nome = %@", searchText)
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
    
}

extension listaUsuarioViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  usuarios.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usuariosTableCell", for: indexPath) as! usuariosTableCell
        cell.lblNome.text = usuarios[indexPath.row]["nome"]
        cell.lblEmail.text = usuarios[indexPath.row]["email"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Aviso", message: "Para editar ou excluir favor deslizar a célula para a esquerda", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let apagar = UITableViewRowAction(style: .destructive, title: "Excluir") { (action, indexPath) in
            
            let alert = UIAlertController(title: "Apagar", message: "Deseja realmente apagar?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Sim", style: UIAlertActionStyle.default) {
                UIAlertAction in
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let managedContext = appDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                request.predicate = NSPredicate(format: "email == %@", self.usuarios[indexPath.row]["email"]!)
                
                let objects = try! managedContext.fetch(request)
                for obj in objects {
                    
                    managedContext.delete(obj as! NSManagedObject)
                }
                
                do {
                    try managedContext.save()
                } catch {
                    debugPrint("erro")
                }
                self.usuarios = []
                tableView.reloadData()
                self.listaUsuarios()
            }
            
            let cancel = UIAlertAction(title: "Não", style: .default, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        let editar = UITableViewRowAction(style: .default, title: "Editar") { (action, indexPath) in
            let cadastroVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cadastroViewController") as! cadastroViewController
            cadastroVC.usuarios = self.usuarios[indexPath.row]
            self.navigationController!.pushViewController(cadastroVC, animated: true)
        }
        
        editar.backgroundColor = UIColor.lightGray
        
        return [apagar, editar]
        
    }
    
}
