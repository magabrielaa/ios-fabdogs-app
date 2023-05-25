//
//  DogListViewController.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/6/23.
//

import UIKit

class DogListViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    // Set to empty array in case myDogs cannot be reassigned data
    var myDogs: [Dog] = []
    var dogService: DogService!
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Favorite dogs
        loadFavoritesFromUserDefaults()
        
        // Display search bar on the view
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        // Set search bar background color to white
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
        }
    
        self.dogService = DogService()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.startAnimating()
        self.view.addSubview(spinner) // Add spinner as subview
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // Center horizontally
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true // Center vertically

    }
    
    // Update results based on text input in the search bar
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let text = searchController.searchBar.text
        else {
            return
        }
        // Case when user inputs text in the search bar
        if !text.isEmpty {
            self.myDogs = self.myDogs.filter {
                $0.name.lowercased().contains(text.lowercased())
            }
            // Show the filtered dogs
            if self.myDogs.count > 0 {
                
                self.tableView.reloadData()
            // No dogs match the search text, show a message
            } else {
                self.myDogs = []
                self.tableView.reloadData()
                if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
                    cell.textLabel?.text = "No matches found"
                } else {
                    let cell = UITableViewCell()
                    cell.textLabel?.text = "No matches found"
                    self.tableView.backgroundView = cell
                }
            }
        // If search bar is empty, show all dogs
        } else {
            fetchDogs()
            self.tableView.reloadData()
        }
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
                
                // Update the isFavorite status of dogs based on UserDefaults
                for dog in dogs {
                    if let isFavorite = UserDefaults.standard.value(forKey: dog.name) as? Bool {
                        dog.isFavorite = isFavorite
                        
                    }
                    
                }
                        
                // Sort the dogs array by name in alphabetical order
                self.myDogs = dogs.sorted(by: { $0.name < $1.name })
                
                // Reload the table view to display the sorted dogs
                self.tableView.reloadData()
                self.spinner.stopAnimating() // Stop spinner animation
            })
        }

    private func loadFavoritesFromUserDefaults() {
        for dog in myDogs {
            if let isFavorite = UserDefaults.standard.value(forKey: dog.name) as? Bool {
                dog.isFavorite = isFavorite
            }
        }
    }

    
    func updateFavoriteSelection(cell: UITableViewCell) {
        // Identify which dog is tapped on
        guard let indexPathTappedOn =  tableView.indexPath(for: cell) else {
            return
        }
        
        let dog = myDogs[indexPathTappedOn.row]

        // Change isFavorite to the opposite of previous state
        let updatedDog = dog
            updatedDog.isFavorite = !dog.isFavorite
        myDogs[indexPathTappedOn.row] = updatedDog
        
        // Save the updated isFavorite value to UserDefaults
        UserDefaults.standard.set(updatedDog.isFavorite, forKey: updatedDog.name)
        
        // Reload cells with updated favorites
        tableView.reloadRows(at: [indexPathTappedOn], with: .fade)
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
            let cell = self.tableView.dequeueReusableCell(withIdentifier:"dogCell") as! DogCell // Force downcast to DogCell
            cell.link = self // Link between DogCell methods and DogListViewController
            
            // 2) put data in the cell
            let currentDog = self.myDogs[indexPath.row]
            cell.dog = currentDog
    
            // 3) Get the favorite selection for the current dog from UserDefaults
            let isFavorite = UserDefaults.standard.bool(forKey: currentDog.name)

            // 4) Set the tint color of the heart button based on the favorite selection
            if let heartButton = cell.contentView.subviews.first(where: { $0 is UIButton }) {
                heartButton.tintColor = isFavorite ? UIColor.systemPink : .lightGray
            }

            // 5) return cell for iOS to display
            return cell
        }
    }
}

extension DogListViewController: UITableViewDelegate{
    // MARK: Delegate
}
