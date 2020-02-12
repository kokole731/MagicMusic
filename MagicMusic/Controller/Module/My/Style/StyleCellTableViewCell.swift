//
//  StyleCellTableViewCell.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/16.
//  Copyright © 2020 Chandler. All rights reserved.
//

import UIKit

class StyleCellTableViewCell: UITableViewCell {

    @IBOutlet weak var styleText: UILabel!
    
    @IBOutlet weak var styleCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
