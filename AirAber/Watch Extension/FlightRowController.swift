//
//  FlightRowController.swift
//  AirAber
//
//  Created by Breno Vinícios Aparecido Valadão on 19/04/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit

class FlightRowController: NSObject {

    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var flightNumberLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var planeImage: WKInterfaceImage!
    
    var flight: Flight? {
        
        didSet {
            if let flight = flight {
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
                flightNumberLabel.setText(flight.number)
                
                if flight.onSchedule {
                    statusLabel.setText("On delay")
                } else {
                    statusLabel.setText("Delayed")
                    statusLabel.setTextColor(UIColor.redColor())
                }
            }
        }
        
    }
    
    func updateForCheckIn() {
        let color = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        planeImage.setTintColor(color)
        separator.setColor(color)
    }
    
    
}
