//
//  FontsTableViewController.swift
//  TestWork
//
//  Created by Anastasia on 6/7/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class FontsTableViewController: UITableViewController {
    var fonts: [Array] = [Array<String>]()
    var familyNames: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllNamesOfFonts()
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func chekSavedMark() -> IndexPath{
        var savedMark: IndexPath = IndexPath()
        if isKeyPresentInUserDefaults(key: "SelectedSection") == true &&  isKeyPresentInUserDefaults(key: "SelectedRow") == true{
            let row: NSNumber = NSNumber(value: UserDefaults.standard.integer(forKey: "SelectedRow"))
            let section: NSNumber = NSNumber(value:UserDefaults.standard.integer(forKey: "SelectedSection"))
            savedMark = IndexPath(row: row.intValue, section: section.intValue)
        }
        return savedMark
    }
    
    func getAllNamesOfFonts() {
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            fonts.append(fontNames)
            familyNames.append(familyName)
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return familyNames.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var savedMark: IndexPath = chekSavedMark()
        if savedMark.isEmpty == false {
            if indexPath.section == savedMark.section && indexPath.row == savedMark.row {
                cell.accessoryType = .checkmark
            }
        }
        cell.textLabel?.font = UIFont(name: "\(fonts[indexPath.section][indexPath.row])", size: 16)
        cell.textLabel?.text = "\(fonts[indexPath.section][indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselctPreviousCheckmark()
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .checkmark
            UserDefaults.standard.set(indexPath.section, forKey: "SelectedSection")
            UserDefaults.standard.set(indexPath.row, forKey: "SelectedRow")
        }
    }
    
    func deselctPreviousCheckmark(){
        if isKeyPresentInUserDefaults(key: "SelectedSection") == true &&  isKeyPresentInUserDefaults(key: "SelectedRow") == true{
            if let cell = tableView.cellForRow(at: chekSavedMark()) {
                cell.accessoryType = .none
                UserDefaults.standard.removeObject(forKey: "SelectedSection")
                UserDefaults.standard.removeObject(forKey: "SelectedRow")
            }
        }
    }
    
}
