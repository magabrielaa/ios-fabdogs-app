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
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.dogService = DogService()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.startAnimating()
        self.view.addSubview(spinner) // Add spinner as subview
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // Center horizontally
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true // Center vertically

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        fetchDogs()
    }
    
        
    func fetchDogs () {
            guard let confirmedService = self.dogService else { return }

            confirmedService.getDogs(completion: { dogs, error in
                guard let dogs = dogs, error == nil else {
                    DispatchQueue.main.async {
                    // Alert Controller when getDogs returns nil due to API call failure
                        let alert = UIAlertController(title: "Error", message: "Failed to fetch dogs", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                                // Remove all cached responses
                                URLCache.shared.removeAllCachedResponses()
                                // Reset to empty array
                                self.myDogs = []
                                // Reload tableView
                                self.tableView.reloadData()
                            }))
                            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                                // If Retry is selected, call the fetch function again
                                self.fetchDogs()
                            }))

                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                self.myDogs = dogs
                self.tableView.reloadData()
                self.spinner.stopAnimating() // Stop spinner animation
            })
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
        
        // If myDogs array is empty, return 1 cell to display a message that alerts the
        // user of this event.
        // Otherwise, return as many cells as there are dogs in the array
        return self.myDogs.isEmpty ? 1 : self.myDogs.count
    }
    
    // Create each cell in the tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.myDogs.isEmpty {
            let cell = UITableViewCell()
            cell.textLabel?.text = "There are currently no dogs"
            return cell
        } else {
            // (1) get cell
            let cell = self.tableView.dequeueReusableCell(withIdentifier:"dogCell") as! DogCell // force downcast
            
            // 2) put data in the cell
            let currentDog = self.myDogs[indexPath.row]
            cell.dog = currentDog
            
            // 3) return cell for iOS to display
            return cell
        }
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
