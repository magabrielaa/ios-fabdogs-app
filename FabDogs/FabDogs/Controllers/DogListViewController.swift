//
//  ViewController.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/6/23.
//

import UIKit

class DogListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Set to empty array in case myDogs cannot be reassigned data
    var myDogs: [Dog] = []
    var dogService: DogService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.dogService = DogService()
        self.dogService.getDogs(completion: { dogs, error in
            guard let dogs = dogs, error == nil else {
                return
                
            }
            self.myDogs = dogs
            self.tableView.reloadData()
            
        })
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            // Cast down from UIViewController to a DetailViewController
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            // Get cell located at the index path and downcast it to DogCell
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? DogCell
            else { return }

        let confirmedDog = confirmedCell.dog
        destination.dog = confirmedDog // destination is DetailViewController
    }
}

// adds UITableViewDataSource functionality to ViewController class
extension DogListViewController: UITableViewDataSource{
    // MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myDogs.count
    }
    
    // Create each cell in the tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // (1) get cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier:"dogCell") as! DogCell // force downcast
        
        // 2) put data in the cell
        let currentDog = self.myDogs[indexPath.row]
        cell.dog = currentDog
        
        // 3) return cell for iOS to display
        return cell
    }
}

extension DogListViewController: UITableViewDelegate{
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let giveTreatAction = UIContextualAction(style: .normal, title: "Give Treat?") { (action, view, completion) in
            if
                let cell = tableView.cellForRow(at: indexPath) as? DogCell,
                let selectedDog = cell.dog
            {
                selectedDog.giveTreat = true
                let treatImageView = UIImageView(image: UIImage(named: "Treat"))
                    treatImageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                cell.accessoryView = selectedDog.giveTreat ? treatImageView : .none
                completion(true)
            }
            else {
                // Handle case where cell cannot be cast to DogCell
                completion(false)
            }
        }
        
        giveTreatAction.backgroundColor = .systemOrange
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [giveTreatAction])
        
        return swipeConfiguration
    }
}
