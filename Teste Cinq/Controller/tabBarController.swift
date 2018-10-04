//
//  tabBarController.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 03/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import UIKit

class tabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Usuários"
        self.navigationItem.hidesBackButton = true
        let botaoSair = UIBarButtonItem(title: "Sair", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.sair(sender:)))
        self.navigationItem.leftBarButtonItem = botaoSair
        
        let botaoCadastro = UIBarButtonItem(title: "Cadastrar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cadastrar(sender:)))
        self.navigationItem.rightBarButtonItem = botaoCadastro
    }
   
    
    @objc func cadastrar(sender: UIBarButtonItem) {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cadastroViewController") as UIViewController
        self.navigationController!.pushViewController(viewController, animated: true)
       
    }
    
    @objc func sair(sender: UIBarButtonItem) {
        
       let alert = UIAlertController(title: "Sair", message: "Deseja realmente sair?", preferredStyle: .alert)
       let okAction = UIAlertAction(title: "Sim", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "usuario")
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as UIViewController
            self.navigationController!.pushViewController(viewController, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Não", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension tabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            self.navigationItem.title = "Usuários"
        case 1:
            self.navigationItem.title = "Fotos"
        default:
            self.navigationItem.title = "Usuários"
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
}

