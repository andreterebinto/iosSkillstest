//
//  ViewController.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 03/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        verificaLogado()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func verificaLogado(){
        let usuario = UserDefaults.standard.string(forKey: "usuario")
        if (usuario != nil){
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as UIViewController
            self.navigationController!.pushViewController(tabBarVC, animated: true)
        }
        
    }
    
    
    
    @IBAction func btnEntrar(_ sender: Any) {
        
        if txtLogin.text == "" && txtSenha.text == ""
        {
            let alert = UIAlertController(title: "Ops", message: "Preencha corretamente os campos", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        else
            
        {
            self.CheckLogin(usuario : txtLogin.text! as String, senha : txtSenha.text! as String)
        }
        
        
       
    }
    
    
    func CheckLogin( usuario: String, senha : String)
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "email = %@", usuario)
        fetchrequest.predicate = predicate
        
        do
        {
           let result = try context.fetch(fetchrequest) as NSArray
            
            if result.count>0
            {
                
                let defaults = UserDefaults.standard
                defaults.set(usuario, forKey: "usuario")
                let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as UIViewController
                self.navigationController!.pushViewController(tabBarVC, animated: true)
            }else{
                let alert = UIAlertController(title: "Ops", message: "Login Inválido", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alert.addAction(ok)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
            
        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
        
    }
    
    
    
    @IBAction func btnCadastrar(_ sender: Any) {
        
        let cadastroVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cadastroViewController") as UIViewController
        self.navigationController!.pushViewController(cadastroVC, animated: true)
        
    }
    
}

