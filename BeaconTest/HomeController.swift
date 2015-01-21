//
//  ViewController.swift
//  BeaconTest
//
//  Created by Neil Williams on 20/01/2015.
//  Copyright (c) 2015 University of South Wales. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class HomeController: UIViewController, CBPeripheralManagerDelegate {
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var transmit: UIButton!
    
    // the UUID our iBeacons will use
    let uuidObj = NSUUID(UUIDString: "A02EF7CA-6926-4E82-AD79-C884FDD22E38")
    // Objects used in the creation of iBeacons 
    var region = CLBeaconRegion()
    var data = NSDictionary()
    var manager = CBPeripheralManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.region = CLBeaconRegion(proximityUUID: uuidObj, major: 9, minor: 6, identifier: "UniBox Apple iBeacon")
        self.info.text = "Awaiting command."
        self.transmit.setTitle("Start iBeacon", forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        if (peripheral.state == CBPeripheralManagerState.PoweredOn){
            self.info.text = "iBeacon powered on."
        } else if peripheral.state == CBPeripheralManagerState.PoweredOff {
            self.info.text = "iBeacon powered off."
        } else {
            self.info.text = "Something went wrong..."
        }
    }
    
    @IBAction func transmitBeacon(sender: UIButton) {
        self.data = self.region.peripheralDataWithMeasuredPower(nil)
        self.manager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        self.transmit.setTitle("Stop iBeacon", forState: UIControlState.Normal)
    }
}

