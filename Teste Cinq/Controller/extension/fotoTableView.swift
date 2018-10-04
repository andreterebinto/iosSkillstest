//
//  fotoTableView.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 04/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import Foundation
import UIKit

extension fotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint(fotos.count)
        return  fotos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fotoTableCell", for: indexPath) as! fotoTableCell
        cell.titulo.text = fotos[indexPath.row]["title"]
        cell.imagem.downloaded(from: fotos[indexPath.row]["thumbnailUrl"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        
    }
    
}

