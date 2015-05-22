//
//  MatchDataViewController.swift
//  PBPlaybook
//
//  Created by Carl Reyes on 5/22/15.
//  Copyright (c) 2015 Carl Reyes. All rights reserved.
//

import UIKit
import Parse
import Charts

class MatchDataViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: BarChartView!
    
    var match: PFObject? = nil
    var points: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
                
            } else {
                println(error)
            }
        }
    }

    
}
