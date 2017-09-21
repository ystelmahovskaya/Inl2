//
//  ReceptTableViewCell.swift
//  Inl2
//
//  Created by Yuliia Stelmakhovska on 2017-09-17.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class ReceptTableViewCell: UITableViewCell {
  
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var imageRecept: UIImageView!

    @IBOutlet weak var descriptiobLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
