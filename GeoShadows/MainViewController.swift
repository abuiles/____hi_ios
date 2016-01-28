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

class MainViewController: UIViewController, CLLocationManagerDelegate {

  // MARK: Properties


    @IBOutlet weak var mapView: RealmMapView!
    @IBOutlet weak var locationsCountLabel: UILabel!
    let locationManager = CLLocationManager()
    let db = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            print("asking for authorization")
            locationManager.requestAlwaysAuthorization()
        } else {
            print("authorized")
        }
        let count = db.objects(Location).count
        locationsCountLabel.text = "Locations count: \(count)"
        self.mapView.delegate = self
        print(db.path)
        

//        let config = Realm.Configuration.defaultConfiguration
//        self.mapView.realmConfiguration = config
        self.mapView.fetchedResultsController.clusterTitleFormatString = "$OBJECTSCOUNT points in this area"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

      // MARK: Core Location

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      print("location changed")
      for location in locations {
            let newLocation =  Location(value: ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude])
            try! db.write {
                db.add(newLocation)
            }
        }
        
        locationsCountLabel.text = "Locations count: \(db.objects(Location).count)"

    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("did change authorization status and")
        if status == .AuthorizedAlways {
            print("is always authorized")
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location failed")
    }

}

extension MainViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let safeObjects = ABFClusterAnnotationView.safeObjectsForClusterAnnotationView(view) {
            
            if let firstObjectName = safeObjects.first?.toObject(Location).title {
                print("First Object: \(firstObjectName)")
            }
        }
    }
}
