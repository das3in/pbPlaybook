//
//  NewMatchViewController.swift
//  ParseStarterProject
//
//  Created by Carl Reyes on 5/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class NewMatchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    var teams: [PFObject] = []
    var team: PFObject? = nil
    var tournament: PFObject? = nil
    var opponent: PFObject? = nil
    var matchNumber: String = ""
    
    @IBOutlet weak var pickerViewContainer: UIView!
    @IBOutlet weak var matchNumberField: UITextField!
    @IBOutlet weak var opponentName: UILabel!

    @IBAction func hideTeamPicker(sender: AnyObject) {
        pickerViewContainer.hidden = true
    }
    @IBAction func showTeamPicker(sender: AnyObject) {
        pickerViewContainer.hidden = false
    }
    

    @IBAction func saveMatchToParse(sender: AnyObject) {

        matchNumber = matchNumberField.text

        var match = PFObject(className: "Match")
        if let tournament = tournament {
            match["tournament_name"] = tournament["name"] as! String
        }
        match["matchNumber"] = matchNumber
        if let team = team  {
            if let opponent = opponent {
                match["teams"] = [team["name"] as! String, opponent["name"] as! String]
            }
        }
        match.saveInBackgroundWithBlock({
            (success: Bool, error: NSError?) -> Void in
            if success {
                self.performSegueWithIdentifier("saveMatch", sender: self)
            } else {
                println(error)
            }
        })
        
        match.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("Saved!")
            } else {
                println(error)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewContainer.hidden = true
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teams.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return teams[row]["name"] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        opponent = teams[row]
        if let opponent = opponent {
            self.opponentName.text = opponent["name"] as? String
        }
    }
    
}
