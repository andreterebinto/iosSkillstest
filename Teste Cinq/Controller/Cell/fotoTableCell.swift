//
//  fotoTableCell.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 04/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//

import Foundation
import UIKit


class fotoTableCell: UITableViewCell {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
