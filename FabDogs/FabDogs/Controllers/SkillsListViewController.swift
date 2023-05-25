//
//  SkillsListViewController.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 5/18/23.
//

import UIKit

class SkillsListViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    var skills: [Skills] = []
    var skillService: SkillService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.skillService = SkillService()
        self.skills = skillService.getSkills()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.reloadData()
        adjustTableViewInsets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustTableViewInsets()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            // Cast down from UIViewController to a DogSkillsViewController
            let destination = segue.destination as? DogSkillsViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow
            else { return }

        let selectedSkill = skills[selectedIndexPath.row]
        destination.skill = selectedSkill
    }
    
    private func adjustTableViewInsets() {
        let tableHeight = tableView.frame.height
        let contentHeight = tableView.contentSize.height
        
        let inset = max(0, tableHeight - contentHeight)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)
    }
}


extension SkillsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.skills.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "skillsCell") as! SkillsCell
        
        let currentSkills = self.skills[indexPath.row]
        
        cell.skill = currentSkills
                
        return cell
    }
}

extension SkillsListViewController: UITableViewDelegate {
    //MARK: Delegate
}
