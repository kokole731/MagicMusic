//
//  LocalMusicCell.swift
//  MagicMusic
//
//  Created by Chandler on 2020/1/11.
//  Copyright © 2020 Chandler. All rights reserved.
//

import UIKit

class LocalMusicCell: UITableViewCell {
    
    //MARK:单元格音乐信息UI
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
