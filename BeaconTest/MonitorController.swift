//
//  MonitorController.swift
//  BeaconTest
//
//  Created by Neil Williams on 21/01/2015.
//  Copyright (c) 2015 University of South Wales. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class MonitorController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var monitor: UIButton!
    
    // the UUID our iBeacons will use
    let uuidObj = NSUUID(UUIDString: "A02EF7CA-6926-4E82-AD79-C884FDD22E38")
    // Objects used in the creation of iBeacons
    var region = CLBeaconRegion()
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.region = CLBeaconRegion(proximityUUID: uuidObj, major: 9, minor: 6, identifier: "UniBox Apple iBeacon")
        self.info.text = "Awaiting command."
        self.monitor.setTitle("Monitor for beacons", forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func monitorBeacons(sender: UIButton) {
        if((UIDevice.currentDevice().systemVersion as NSString).substringToIndex(1).toInt() >= 8){
            self.manager.requestAlwaysAuthorization()
        }
        self.manager.startMonitoringForRegion(self.region)
        self.info.text = "Starting Monitor..."
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        self.info.text = "Scanning..."
        manager.startRangingBeaconsInRegion(region as CLBeaconRegion) //testing line 
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) { manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
        self.info.text = "Possible Match"
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        self.info.text = "Error :("
        println(error)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) { manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
        self.info.text = "Not found."
    }
}

