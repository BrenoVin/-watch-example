//
//  BoardingPassInterfaceController.swift
//  AirAber
//
//  Created by Breno Vinícios Aparecido Valadão on 20/04/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class BoardingPassInterfaceController: WKInterfaceController {
    
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var boardingPassImage: WKInterfaceImage!
    
    var flight: Flight? {
        didSet {
            if let flight = flight {
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
                
                if let _ = flight.boardingPass {
                    showBoardingPass()
                }
            }
        }
    }
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        if let flight = context as? Flight { self.flight = flight }

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func didAppear() {
        super.didAppear()

        if let flight = flight where flight.boardingPass == nil && WCSession.isSupported() {

            session = WCSession.defaultSession()

            session!.sendMessage(["reference": flight.reference], replyHandler: { (response) -> Void in
                if let boardingPassData = response["boardingPassData"] as? NSData, boardingPass = UIImage(data: boardingPassData) {
                    flight.boardingPass = boardingPass
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showBoardingPass()
                    })
                }
                }, errorHandler: { (error) -> Void in
                    print(error)
            })
        }
    }
    
    private func showBoardingPass() {
        
        boardingPassImage.stopAnimating()
        boardingPassImage.setWidth(120)
        boardingPassImage.setHeight(120)
        boardingPassImage.setImage(flight?.boardingPass)
    }

}

extension BoardingPassInterfaceController: WCSessionDelegate {
    
}
