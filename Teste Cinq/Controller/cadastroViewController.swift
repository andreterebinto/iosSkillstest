//
//  cadastroViewController.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 03/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class cadastroViewController: UIViewController {
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnCad: UIButton!
    var usuarios = [String:String]()
    
    override func viewDidLoad() {
         super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if(usuarios.count > 0 ){
            txtNome.text = usuarios["nome"]?.description
            txtEmail.text = usuarios["email"]?.description
            txtSenha.text = usuarios["senha"]?.description
            btnCad.setTitle("Atualizar", for: .normal)
        }
        
    }
    
    @available(iOS 10.0, *)
    @IBAction func btnCadastrar(_ sender: Any) {
        
         if(usuarios.count > 0 ){
            atualizar()
         }else{
            cadastrar()
        }
        
    }
    
    
    func cadastrar(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(txtNome.text, forKeyPath: "nome")
        newUser.setValue(txtEmail.text, forKey: "email")
        newUser.setValue(txtSenha.text, forKey: "senha")
        
        do {
            try context.save()
            
            let alert = UIAlertController(title: "Sucesso", message: "Cadastro Realizado!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as UIViewController
                self.navigationController!.pushViewController(viewController, animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        } catch let error as NSError {
            print("Nao salvou. \(error), \(error.userInfo)")
        }
    }
    
    
    func atualizar(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email == %@", self.usuarios["email"]!)
        
        do
        {
            let usuario = try managedContext.fetch(request)
            if usuario.count == 1
            {
                let objectUpdate = usuario[0] as! NSManagedObject
                objectUpdate.setValue(txtNome.text, forKey: "nome")
                objectUpdate.setValue(txtEmail.text, forKey: "email")
                objectUpdate.setValue(txtSenha.text, forKey: "senha")
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
        
        
        let alert = UIAlertController(title: "Sucesso", message: "Atualizado com sucesso!", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
