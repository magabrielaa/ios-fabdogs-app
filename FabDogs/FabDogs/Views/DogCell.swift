//
//  DogCell.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/7/23.
//

import UIKit

class DogCell: UITableViewCell {
    
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogPersonalityLabel: UILabel!
    
    let treatImageView = UIImageView(image: UIImage(named: "treat"))
    
    var dog: Dog? {
        didSet {
            self.dogNameLabel.text = dog?.name
            self.dogPersonalityLabel.text = dog?.personality
            self.accessoryType = dog!.confirmedSighting ? .checkmark : .none
            self.accessoryView = dog!.giveTreat ? treatImageView : .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
