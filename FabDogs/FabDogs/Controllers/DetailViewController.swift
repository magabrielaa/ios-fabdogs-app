//
//  DetailViewController.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/10/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogPersonalityLabel: UILabel!
    @IBOutlet weak var dogActivityLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    
    var dog: Dog!
    
    // Called first time view is accessed on ViewController
    override func loadView() {
        super.loadView()
    }
    
    // Once view is loaded, it is available for communications
    override func viewDidLoad() {
            
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            if let dog = self.dog {
                self.dogNameLabel.text = dog.name
                self.dogPersonalityLabel.text = dog.personality
                self.dogPersonalityLabel.numberOfLines = 0 // Enable line wrapping
                self.dogPersonalityLabel.textAlignment = .center // Center the text
                self.dogActivityLabel.text = dog.ability
                
                DispatchQueue.global(qos: .userInitiated).async {
                    if let dogImageData = NSData(contentsOf: URL(string: dog.imageUrl)!){
                        DispatchQueue.main.async {
                            self.dogImageView.image = UIImage(data: dogImageData as Data)
                            self.dogImageView.layer.cornerRadius = self.dogImageView.frame.width / 2
                        }
                    }
                }
            }

        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? MapViewController {
            destination.latitude = self.dog.lat
            destination.longitude = self.dog.lon
            destination.name = self.dog.name
            destination.origin = self.dog.origin
        }
        
    }
}
