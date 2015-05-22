//
//  TeamsViewController.swift
//  ParseStarterProject
//
//  Created by Carl Reyes on 5/3/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class TeamsViewController: UITableViewController {
    
    var teams: [PFObject] = []
    var tournament:PFObject? = nil

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let team:PFObject = teams[indexPath.row]
        self.performSegueWithIdentifier("jumpToMatchList", sender: team)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "jumpToMatchList" {
            // (segue.destinationViewController as! MatchesViewController).team = (sender as! PFObject)
            var matches = segue.destinationViewController as! MatchesViewController
            matches.team = sender as? PFObject
            matches.teams = teams
            matches.tournament = tournament
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var team: PFObject = teams[indexPath.row]
        cell.textLabel?.text = team["name"] as? String
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team List"
        if let teams:AnyObject = tournament!["teams"]
        {
            var teamIds:[String] = teams as! [String]
            var query = PFQuery(className:"Team")
            query.whereKey("objectId", containedIn: teamIds)
            query.findObjectsInBackgroundWithBlock {
                (teams: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    self.teams = teams as! [PFObject]
                }
                self.tableView.reloadData()
            }
        }
        self.tableView.reloadData()
    }
}

