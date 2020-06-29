//
//  ProductCell.swift
//  Realm Demo
//
//  Created by Ercan on 29.06.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
