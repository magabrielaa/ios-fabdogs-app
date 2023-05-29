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
    @IBOutlet weak var dogImageView: UIImageView!
    
    let treatImageView = UIImageView(image: UIImage(named: "treat"))
    
    var dog: Dog? {
        didSet {
            self.dogNameLabel.text = dog?.name
            self.dogPersonalityLabel.text = dog?.personality
            self.accessoryView = dog!.giveTreat ? treatImageView : .none
            
            DispatchQueue.global(qos: .userInitiated).async {
                // Cast imageUrl string into a URL object, pass it to NSData which turns into data
                if let dogImageData = NSData(contentsOf: URL(string: self.dog!.imageUrl)!) {
                    DispatchQueue.main.async {
                        // Pass data into a UIImage intializer to set on Image View
                        self.dogImageView.image = UIImage(data: dogImageData as Data)
                        self.dogImageView.layer.cornerRadius = self.dogImageView.frame.width / 2
                    }
                }
            }
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
