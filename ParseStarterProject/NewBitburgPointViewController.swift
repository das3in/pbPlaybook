//
//  NewPointViewController.swift
//  ParseStarterProject
//
//  Created by Carl Reyes on 5/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class NewBitburgPointViewController: UIViewController {
    
    var surviveSelectedColor: UIColor = UIColor(red: 0.0, green: 255, blue: 0.0, alpha: 1)
    var surviveShootingSelectedColor: UIColor = UIColor.blueColor()
    var diedSelectedColor: UIColor = UIColor.redColor()
    
    var bunkersArray: [UIButton]!
    
    // Bunker Outlets
    @IBOutlet weak var dorito_corner: UIButton!
    @IBOutlet weak var dorito_one: UIButton!
    @IBOutlet weak var dorito_two: UIButton!
    @IBOutlet weak var dorito_three: UIButton!
    @IBOutlet weak var delta: UIButton!
    @IBOutlet weak var rascoe: UIButton!
    @IBOutlet weak var rocket: UIButton!
    @IBOutlet weak var china: UIButton!
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var command_center: UIButton!
    @IBOutlet weak var xbox: UIButton!
    @IBOutlet weak var san_antonio: UIButton!
    @IBOutlet weak var center_a: UIButton!
    @IBOutlet weak var california: UIButton!
    @IBOutlet weak var closet: UIButton!
    @IBOutlet weak var money: UIButton!
    @IBOutlet weak var god: UIButton!
    @IBOutlet weak var snake_corner: UIButton!
    @IBOutlet weak var snake_one: UIButton!
    @IBOutlet weak var ghetto: UIButton!
    @IBOutlet weak var chicago: UIButton!
    
    // Other Outlets
    
    @IBOutlet weak var opponentLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var winSwitch: UISwitch!
    @IBAction func save(sender: AnyObject) {
        save()
    }
    
    
    
    var match: PFObject? = nil
    var teams = [""]
    var winner = ""
    var selectedBunkers: [String] = []
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        winSwitch.addTarget(self, action: "switchStateChanged:", forControlEvents: .ValueChanged)
        initButtons()
        
        if let match = match {
            teams = match["teams"] as! [String]
        }
        
        teamLabel.text = teams[0]
        opponentLabel.text = teams[1]
    }
    
    // Initialize Bunkers
    func initButtons() {
        self.bunkersArray = [dorito_corner, dorito_one, dorito_two, dorito_three, delta, rascoe, rocket, china, home, command_center, xbox, san_antonio, center_a, california, closet, money, god, snake_corner, snake_one, ghetto, chicago]
        
        for bunker in bunkersArray {
            bunker.addTarget(self, action: "bunkerClicked:", forControlEvents: .TouchUpInside)
        }
    }
    
    // Handle bunker clicks
    func bunkerClicked(sender: UIButton) {
        // If the bunker is already selected, deselect it and remove custom styling
        if (sender.selected == true) {
            sender.selected = false;
            sender.layer.borderWidth = 0
            return
        }
        
        // Set the number of selected bunkers to zero and iterate over the array of bunkers.
        // If a bunker is marked as selected, increment the bunker count
        var selectedBunkerCount = 0
        for bunker in bunkersArray {
            if( bunker.selected == true) {
                selectedBunkerCount++
            }
        }
        
        // If there are more than 5 bunkers selected, the clicked function does nothing
        if (selectedBunkerCount >= 5) {
            return
        }
        
        // Mark bunker as selected, set custom styling
        sender.selected = true
        
        println(sender.titleLabel?.text)
        
        sender.layer.borderWidth = 5
        sender.layer.borderColor = surviveSelectedColor.CGColor
    }
    
    // Winner/Loser switch
    func switchStateChanged(sender: UISwitch) {
        if winSwitch.on {
            opponentLabel.textColor = UIColor.greenColor()
            teamLabel.textColor = UIColor.blackColor()
            winner = opponentLabel.text!
        } else {
            teamLabel.textColor = UIColor.greenColor()
            opponentLabel.textColor = UIColor.blackColor()
            winner = teamLabel.text!
        }
    }
    
    func save() {
        
        for bunker in bunkersArray {
            if (bunker.selected == true) {
                var title = bunker.titleForState(.Normal)
                self.selectedBunkers.append(title!)
            }
        }
        
        var point = PFObject(className: "Point")
        point["matchId"] = match?.objectId
        point["winner"] = winner
        point["breakoutBunkers"] = selectedBunkers
        
        point.saveInBackgroundWithBlock({
            (success: Bool, error: NSError?) -> Void in
            if success {
                self.performSegueWithIdentifier("saveBitburgPoint", sender: self)
            } else {
                println(error)
            }
        })
        
        point.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("Saved!")
            } else {
                println(error)
            }
        }
    }
}
