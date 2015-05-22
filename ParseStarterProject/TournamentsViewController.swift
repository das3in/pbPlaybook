//
//  TournamentsViewController.swift
//  ParseStarterProject
//
//  Created by Carl Reyes on 5/3/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class TournamentsViewController: UITableViewController {
    
    var tournaments: [PFObject] = []
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = tournaments[indexPath.row]["name"] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tournament:PFObject = tournaments[indexPath.row]
        self.performSegueWithIdentifier("jumpToTeamList", sender: tournament)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "jumpToTeamList" {
            (segue.destinationViewController as! TeamsViewController).tournament = (sender as! PFObject)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tournaments"
        
        var query = PFQuery(className: "Tournament")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            self.tournaments.removeAll(keepCapacity: true)
            
            if let objects = objects as? [PFObject] {
                for object in objects {
                    var tournament: PFObject = object as PFObject
                    self.tournaments.append(tournament)
                }
            }
            
            self.tableView.reloadData()
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
}
