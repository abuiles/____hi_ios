//
//  ViewController.swift
//  GeoShadows
//
//  Created by Adolfo on 1/28/16.
//  Copyright © 2016 Adolfo Builes. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift
import RealmMapView
import KCFloatingActionButton

class MainViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Properties

    @IBOutlet weak var mapView: RealmMapView!

    let locationManager = CLLocationManager()
    let db : Realm  = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Delegates
        locationManager.delegate = self

        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            print("authorized")
        }

        // print(db.path)

        // try! db.write {
        //     db.deleteAll()
        // }

        // try! db.write {
        //     for info in Point().points() {
        //         let dateFormatter = NSDateFormatter()
        //         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        //         var date = dateFormatter.dateFromString(info[2])

        //         if (date == nil) {
        //             dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //             date = dateFormatter.dateFromString(info[2])
        //         }

        //         print(date)

        //         let attrs = [
        //             "lat": info[0],
        //             "lon": info[1]
        //         ]

        //         var newL = Location()
        //         newL.latitude = Double(attrs["lat"]!)!
        //         newL.longitude = Double(attrs["lon"]!)!
        //         newL.date =  date!

        //         db.add(newL)
        //     }
        // }
        // print(db.objects(Location).count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

      // MARK: Core Location

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        try! db.write {
            for location in locations {
                let attributes = [
                    "latitude": location.coordinate.latitude,
                    "longitude": location.coordinate.longitude
                ]

                db.add(Location(value: attributes))
            }
        }
        locationManager.allowDeferredLocationUpdatesUntilTraveled(500, timeout: CLTimeIntervalMax)
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.distanceFilter = 500
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location manager failed")
    }

}
