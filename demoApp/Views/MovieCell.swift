//
//  MovieCell.swift
//  demoApp
//
//  Created by Ashutosh Singh on 03/03/25.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
