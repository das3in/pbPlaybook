//
//  MatchesViewController.swift
//  ParseStarterProject
//
//  Created by Carl Reyes on 5/4/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UITableViewController {
    
    var tournament: PFObject? = nil
    var team: PFObject? = nil
    var teams: [PFObject] = []
    var matches: [PFObject] = []
    
    var refresher: UIRefreshControl!
    
    
    @IBAction func saveMatchDetail(segue: UIStoryboardSegue) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Matches"
        
        queryMatches()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refreshing Matches")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
    }
    
    override func viewDidAppear(animated: Bool) {
        var addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonMethod")
        var dataButton = UIBarButtonItem(title: "Match Data", style: UIBarButtonItemStyle.Plain, target: self, action: "dataButtonMethod")
        self.navigationItem.setRightBarButtonItems([addButton, dataButton], animated: true)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        let match: PFObject = matches[indexPath.row]
        var matchNumberString = match["matchNumber"] as? String
        var matchTeams = match["teams"] as! [String]
        var opponent = matchTeams[1]
        cell.textLabel?.text = "Match #" + matchNumberString! + " - " + opponent
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let match:PFObject = matches[indexPath.row]
        println(match)
        self.performSegueWithIdentifier("jumpToPointsList", sender: match)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "jumpToNewMatch" {
            var newMatch = segue.destinationViewController as! NewMatchViewController
            newMatch.teams = teams
            newMatch.team = team
            newMatch.tournament = tournament
        } else if segue.identifier == "jumpToPointsList" {
            var points = segue.destinationViewController as! PointsViewController
            points.match = sender as? PFObject
            points.tournament = sender as? PFObject
        }
    }
    
    
    func addButtonMethod() {
        self.performSegueWithIdentifier("jumpToNewMatch", sender: self)
    }
    
    func dataButtonMethod() {
        self.performSegueWithIdentifier("jumptoMatchData", sender: self)
    }
    
    func queryMatches() {
        var query = PFQuery(className: "Match")
        
        if let tournament = tournament {
            query.whereKey("tournament_name", equalTo: tournament["name"] as! String)
        }
        if let team = team {
            query.whereKey("teams", equalTo: team["name"] as! String)
        }
        
        query.findObjectsInBackgroundWithBlock {
            (matches: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.matches = matches as! [PFObject]
                self.tableView.reloadData()
            } else {
                println(error)
            }
            self.refresher.endRefreshing()
        }
    }
    
    func refresh() {
        queryMatches()
        
    }
}
