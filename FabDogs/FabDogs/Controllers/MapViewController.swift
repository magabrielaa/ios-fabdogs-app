//
//  MapViewController.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 5/10/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude: Double?
    var longitude: Double?
    var name: String?
    var origin: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the title of the navigation bar
        if let name {
            self.navigationItem.title = "\(name)'s Origin"
        }
            
        // create pin and annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
        
        if let origin {
            let title = "\(origin)"
            annotation.title = title
        }
        
        // add annotation to the map view
        mapView.addAnnotation(annotation)
        
        // show the region of the coordinates as soon as the map view loads
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 7600000, longitudinalMeters: 7600000)
        mapView.setRegion(region, animated: true)
    }
        
}
