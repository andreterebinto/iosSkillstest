//
//  usuariosTableCell.swift
//  Teste Cinq
//
//  Created by Andre Terebinto on 03/10/18.
//  Copyright © 2018 Andre Terebinto. All rights reserved.
//


import UIKit

class usuariosTableCell: UITableViewCell {
    
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
