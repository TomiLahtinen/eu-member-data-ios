//
//  MapViewController.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 27/04/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var country: Country!
    var viewModel: CapitalViewModel?
    
    override func viewDidLoad() {
        
        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        
        viewModel = CapitalViewModel(selected: self.country,
                                     loaded: ({ countries in
                                        let annotations = countries
                                            .map { country in
                                                CapitalAnnotation(country.capital)
                                        }
                                        self.mapView.addAnnotations(annotations)
                                        self.mapView.showAnnotations(annotations, animated: true)
                                        
                                     }), distancesUpdated: ({
                                        debugPrint("Distances updated")
                                        self.tableView.reloadData()
                                     }))
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var cap = mapView.dequeueReusableAnnotationView(withIdentifier: "CapitalAnnotation")
        if cap == nil {
            cap = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CapitalAnnotation")
            cap?.canShowCallout = true
            (cap as? MKPinAnnotationView)?.pinTintColor = MKPinAnnotationView.redPinColor()
        }
        
        // Color selected capital green
        if (annotation as! CapitalAnnotation).capital == self.country.capital {
            (cap as? MKPinAnnotationView)?.pinTintColor = MKPinAnnotationView.greenPinColor()
        }
        
        return cap
    }
}
extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.capitalDistances?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let capitalDistance = viewModel?.capitalDistances![indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CapitalDistanceCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "CapitalDistanceCell")
        }
        
        cell?.textLabel?.text = capitalDistance?.0.name[Utils.userLang]
        cell?.detailTextLabel?.text = String(format: "%.1f km", ((capitalDistance?.1)! / 1000))
        
        return cell!
    }
    
    
}
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        viewModel?.updateDistances(from: location)
    }
}

class CapitalAnnotation: NSObject, MKAnnotation {
    
    let capital: Capital
    
    var title: String? {
        return capital.name[Utils.userLang]
    }
    
    init(_ capital: Capital) {
        self.capital = capital
        super.init()
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(capital.coordinate.latitude, capital.coordinate.longitude)
    }
}
