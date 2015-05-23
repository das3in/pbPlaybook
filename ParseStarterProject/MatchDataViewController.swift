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
    var bunkers: [String] = []
    var uniqueBunkers = Set<String>()
    var bunkersCount = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        
        chartView.descriptionText = ""
        chartView.noDataTextDescription = "Data will be loaded soon"
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        
        chartView.maxVisibleValueCount = 60
        chartView.pinchZoomEnabled = false
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = false
        
        // Do any additional setup after loading the view.

        getBunkersFromPoints()
        getBunkerCount()
        getChartData()
        println(bunkersCount)
    }
    
    func getBunkerCount() {
        for bunker in bunkers {
            if (!uniqueBunkers.contains(bunker)) {
                uniqueBunkers.insert(bunker);
                bunkersCount[bunker] = 1
            } else {
                bunkersCount[bunker] = bunkersCount[bunker]! + 1
            }
        }
    }
    

    func getBunkersFromPoints() {
        if let points = points as? [PFObject] {
            for point in points {
                for breakout in point["breakoutBunkers"] as! NSArray {
                    self.bunkers.append(breakout as! String)
                }
            }
        }
    }

    

    
    func getChartData() {
        
        var bunkerKeys: [String] = []
        var counts: [Int] = []
        
        for bunker in bunkersCount.keys {
            bunkerKeys.append(bunker)
        }
        
        for count in bunkersCount.values {
            counts.append(count)
        }
        
        let xVals = bunkerKeys
        var yVals: [BarChartDataEntry] = []
        
        for idx in 0...6 {
            yVals.append(BarChartDataEntry(value: Float(counts[idx]), xIndex: idx))
        }
        
        let set1 = BarChartDataSet(yVals: yVals, label: "Bunker Frequency")
        set1.barSpace = 0.15
        
        let data = BarChartData(xVals: xVals, dataSet: set1)
        data.setValueFont(UIFont(name: "Avenir", size: 12))
        self.chartView.data = data
        self.view.reloadInputViews()
        
    }
}
