//
//  LocationViewController.swift
//  MyLocation
//
//  Created by elahiammar on 9/3/16.
//  Copyright © 2016 elahiammar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressMapView: MKMapView!
    var addressString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addressLabel.text = self.addressString   //Set locationName in Label
        forwardGeocindingFunction(self.addressString) //Show location in map
    }
    
    // MARK: - Private Functions
    
    fileprivate func forwardGeocindingFunction(_ addressString: String) {
        CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
            if error != nil {
                // Show Error Alert
                let alertController = UIAlertController.init(title: "Error!", message: error?.localizedDescription, preferredStyle:.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
                
            } else {
                if (placemarks?.count)! > 0 {
                    let placemark = placemarks![0]
                    let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                    let coordinate = placemark.location!.coordinate
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    self.addressMapView.setRegion(region, animated: true)
                    
                    self.addressMapView.delegate = self // Set Delegate
                    
                    self.addAnnotations(coordinate)
 
                }
            }
        }
    }
    
    fileprivate func addAnnotations(_ coordinate: CLLocationCoordinate2D) {
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        addressMapView.addAnnotation(point)
        
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
            
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = false
            annotationView.image = UIImage(named: "annotationImage")
        }
        
        return annotationView
    }
    
}
