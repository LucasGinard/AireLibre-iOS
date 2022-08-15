//
//  InfoAQITableViewCell.swift
//  airelibre
//
//  Created by LucasG on 2022-08-14.
//

import UIKit

class InfoAQITableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescriptionInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title:String,description:String){
        labelTitle.text = title
        labelDescriptionInfo.text = description
        backgroundView?.backgroundColor
    }
    
}
