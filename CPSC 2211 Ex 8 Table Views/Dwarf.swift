//
//  Dwarf.swift
//  CPSC 2211 Ex 8 Table Views
//
//  Created by James Young on 2/22/18.
//  Copyright © 2018 James Young. All rights reserved.
//
import UIKit
import Foundation
class Dwarf
{
    var name:String
    var hairColour:String
    var height:String
    var imageName:UIImage
    init(name : String, hairColour : String, height : String, imageName : String)
    {
        self.name = name
        self.hairColour = hairColour
        self.height = height
        self.imageName = UIImage(named: imageName)!
    }
    func getDwarfName() -> String
    {
        return name
    }
    func getDwarfHair() -> String
    {
        return hairColour
    }
    func getDwarfHeight() -> String
    {
        return height
    }
    /*
    func getDwarfImage() -> String
    {
        return imageName
    }
 */
}
