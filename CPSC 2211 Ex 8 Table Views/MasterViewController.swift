//
//  MasterViewController.swift
//  CPSC 2211 Ex 8 Table Views
//
//  Created by James Young on 2/22/18.
//  Copyright © 2018 James Young. All rights reserved.
//

import UIKit
protocol DwarfSelectionDelegate: class {
    func dwarfSelected(_ newDwarf: Dwarf)
}
class MasterViewController: UITableViewController{
    
    weak var delegate: DwarfSelectionDelegate?
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var tolkein:[Dwarf] = []
    var disney:[Dwarf] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //disney
        let Sleepy = Dwarf(name: "Sleepy", hairColour: "White", height: "125cm", imageName: "Sleepy")
        let Grumpy = Dwarf(name: "Grumpy", hairColour: "White", height: "122cm", imageName: "Grumpy")
        let Sneezy = Dwarf(name: "Sneezy", hairColour: "White", height: "117cm", imageName: "Sneezy")
        let Bashful = Dwarf(name: "Bashful", hairColour: "White", height: "135cm", imageName: "Bashful")
        let Happy = Dwarf(name: "Happy", hairColour: "White", height: "111cm", imageName: "Happy")
        let Doc = Dwarf(name: "Doc", hairColour: "White", height: "125cm", imageName: "Doc")
        let Dopey = Dwarf(name: "Dopey", hairColour: "White", height: "113cm", imageName: "Dopey")
        disney.append(Sleepy)
        disney.append(Grumpy)
        disney.append(Sneezy)
        disney.append(Bashful)
        disney.append(Happy)
        disney.append(Doc)
        disney.append(Dopey)
        //tolkein
        let Thorin = Dwarf(name: "Thorin", hairColour: "Brown", height: "135cm", imageName: "Thorin")
        let Dori = Dwarf(name: "Dori", hairColour: "White", height: "120cm", imageName: "Dori")
        tolkein.append(Thorin)
        tolkein.append(Dori)
        
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if indexPath.section == 1
                {
                    let object = disney[indexPath.row]
                    let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                    controller.dwarf = object
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
                else
                {
                    let object = tolkein[indexPath.row]
                    let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                    controller.dwarf = object
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    }

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let section = tableView.indexPathForSelectedRow?.section
            if section == 1
            {
                destination.dwarf = disney[(section)!]
            }
            else
            {
                destination.dwarf = tolkein[(section)!]
            }
        }
    }
*/
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1
        {
            return disney.count
        }
        return tolkein.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Disney Dwarves"
        }
        return "Tolkein Dwarves"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        if indexPath.section == 1
        {
            cell.dwarfLbl.text = disney[indexPath.row].getDwarfName()
            cell.dwarfImage.image = disney[indexPath.row].imageName
        }
        else
        {
            cell.dwarfLbl.text = tolkein[indexPath.row].getDwarfName()
            cell.dwarfImage.image = tolkein[indexPath.row].imageName
        }
        cell.dwarfView.layer.cornerRadius = cell.dwarfView.frame.height / 2
        cell.dwarfImage.layer.cornerRadius = cell.dwarfImage.frame.height / 2
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            let selectedDwarf = disney[indexPath.row]
            delegate?.dwarfSelected(selectedDwarf)
            if let detailViewController = delegate as? DetailViewController,
                let detailNavigationController = detailViewController.navigationController {
                splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
            }
        }
        else
        {
            let selectedDwarf = tolkein[indexPath.row]
            delegate?.dwarfSelected(selectedDwarf)
            if let detailViewController = delegate as? DetailViewController,
                let detailNavigationController = detailViewController.navigationController {
                splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
            }
        }
        
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

