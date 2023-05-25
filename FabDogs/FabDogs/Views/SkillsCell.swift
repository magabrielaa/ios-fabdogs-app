//
//  SkillsCell.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 5/18/23.
//

import UIKit

class SkillsCell: UITableViewCell {
    
    @IBOutlet weak var skillDescriptionLabel: UILabel!
    @IBOutlet weak var skillNameLabel: UILabel!
    @IBOutlet weak var skillImageView: UIImageView!
    
    var skill: Skills? {
            didSet {
                self.skillNameLabel.text = skill?.name
                self.skillDescriptionLabel.text = skill?.shortDesc
                self.skillDescriptionLabel.numberOfLines = 0
                self.skillDescriptionLabel.lineBreakMode = .byWordWrapping
                
                if let imageUrlString = skill?.imageUrl, let imageUrl = URL(string: imageUrlString) {
                    DispatchQueue.global(qos: .userInitiated).async {
                        if let imageData = try? Data(contentsOf: imageUrl) {
                            let image = UIImage(data: imageData)
                            DispatchQueue.main.async {
                                self.skillImageView.image = image
                            }
                        }
                    }
                }
            }
        }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        skillDescriptionLabel.preferredMaxLayoutWidth = skillDescriptionLabel.bounds.width
        skillNameLabel.preferredMaxLayoutWidth = skillNameLabel.bounds.width
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
