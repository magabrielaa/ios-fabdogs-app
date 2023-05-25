//
//  FavoriteDogCell.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 5/14/23.
//

import UIKit

class FavoriteDogCell: UITableViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogPersonalityLabel: UILabel!
    
    var link: FavoritesViewController?

    var dog: Dog? {
        didSet {
            self.dogNameLabel.text = dog?.name
            self.dogPersonalityLabel.text = dog?.personality
            
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
        let heartButton = UIButton(type: .system)
        heartButton.setImage(UIImage(named: "icFavorites"), for: .normal)
        heartButton.setImage(UIImage(named: "icFavorites"), for: .normal)
        heartButton.addTarget(self, action: #selector(handleFavoriteSelection), for: .touchUpInside)
        contentView.addSubview(heartButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let heartButton = contentView.subviews.first(where: { $0 is UIButton }) as? UIButton {
            let buttonSize = CGSize(width: 60, height: 60)
            let xPosition = contentView.frame.width - buttonSize.width - 15 // Add margin of 15 points from the right edge
            let yPosition = (contentView.frame.height - buttonSize.height) / 2 // Center the button vertically
            heartButton.frame = CGRect(origin: CGPoint(x: xPosition, y: yPosition), size: buttonSize)
        }
    }
    
    @objc func handleFavoriteSelection () {
        print("Marked as favorite")
        link?.updateFavoriteSelection(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
