//
//  ViewController.swift
//  Project_16
//
//  Created by PC on 08/07/2020.
//  Copyright © 2020 db. All rights reserved.
//
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.12575), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Olslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousend years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .green
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    @IBAction func changeMapType(_ sender: Any) {
        let mapType = UIAlertController(title: "Map type", message: nil, preferredStyle: .actionSheet)
        
        mapType.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self ] _ in  self?.mapView.mapType = .standard } ))
        mapType.addAction(UIAlertAction(title: "Standard - clear", style: .default, handler: { [weak self ] _ in  self?.mapView.mapType = .mutedStandard} ))
        mapType.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self ] _ in  self?.mapView.mapType = .hybrid } ))
        mapType.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self ] _ in  self?.mapView.mapType = .satellite } ))
        
        present( mapType, animated: true)
    }
}

