//
//  PointsTableViewController.swift
//  ParseStarterProject
//
//  Created by Carl Reyes on 5/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class PointsViewController: UITableViewController {
    
    var tournament: PFObject? = nil
    var match: PFObject? = nil
    var points: [PFObject] = []
    
    @IBAction func savePointDetail(segue: UIStoryboardSegue) {
        
    }
    
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Points"
        
        queryPoints()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refreshing Points")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
    }
    
    override func viewDidAppear(animated: Bool) {
        var addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonMethod")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var point = points[indexPath.row]
        var indexPathString = String(indexPath.row + 1)
        cell.textLabel?.text = "Point \(indexPathString)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "jumpToNewBitburgPoint" {
            var newPoint = segue.destinationViewController as! NewBitburgPointViewController
            newPoint.match = match
        }
    }
    
    func addButtonMethod() {
        self.performSegueWithIdentifier("jumpToNewBitburgPoint", sender: self)
    }
    
    
    func queryPoints() {
        var query = PFQuery(className: "Point")
        if let match = match {
            query.whereKey("matchId", equalTo: match.objectId!)
        }
        query.findObjectsInBackgroundWithBlock {
            (points: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.points = points as! [PFObject]
                self.tableView.reloadData()
                
            } else {
                println(error)
            }
            self.refresher.endRefreshing()
        }
    }
    
    func refresh() {
        queryPoints()
    }
}
