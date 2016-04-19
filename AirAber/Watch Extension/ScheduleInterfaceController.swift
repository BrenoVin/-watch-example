//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by Breno Vinícios Aparecido Valadão on 19/04/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

    var selectedIndex = 0
    
    @IBOutlet var flightsTable: WKInterfaceTable!
    var flights = Flight.allFlights()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
        
        for index in 0..<flightsTable.numberOfRows {
            if let controller = flightsTable.rowControllerAtIndex(index) as? FlightRowController {
                controller.flight = flights[index]
            }
        }
    }
    
    override func didAppear() {
        super.didAppear()

        if flights[selectedIndex].checkedIn, let controller = flightsTable.rowControllerAtIndex(selectedIndex) as? FlightRowController {

            animateWithDuration(0.35, animations: { () -> Void in

                controller.updateForCheckIn()
            })
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        let flight = flights[rowIndex]
        let controllers = ["Flight", "CheckIn"]
        
        presentControllerWithNames(controllers, contexts:[flight, flight])
        
        selectedIndex = rowIndex

    }

}
