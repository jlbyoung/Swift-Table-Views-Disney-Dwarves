//
//  DetailViewController.swift
//  CPSC 2211 Ex 8 Table Views
//
//  Created by James Young on 2/22/18.
//  Copyright © 2018 James Young. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dwarfLbl: UILabel!
    @IBOutlet weak var hairLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    
    var dwarf: Dwarf? {
        didSet {
            // Update the view.
           configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        loadViewIfNeeded()
        if let new = dwarf {
            if let label = dwarfLbl{
                label.text = new.getDwarfName()
            }
        }
        if let new = dwarf {
            if let label = hairLbl{
                label.text = new.getDwarfHair()
            }
        }
        if let new = dwarf {
            if let label = heightLbl{
                label.text = new.getDwarfHeight()
            }
        }
        
        if let new = dwarf{
            if let image = imageView{
                image.image = new.imageName
            }
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailViewController: DwarfSelectionDelegate {
    func dwarfSelected(_ newDwarf: Dwarf) {
        dwarf = newDwarf
    }
}
