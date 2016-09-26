//
//  ViewController.swift
//  mapas
//
//  Created by Irving Medina on 9/24/16.
//  Copyright © 2016 Alan Crown. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()//clase que se encarga de saver la posicion del usuario
    
    func action(_ gestureRecognizer: UIGestureRecognizer){
        //marca la posicion dentro de la interfaz mas no las coordenadas
        let touchPoint = gestureRecognizer.location(in: self.map)
        
        //debuelve que corrdenadas esta el punto seleccionado
        let newCoordinate: CLLocationCoordinate2D = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "Coordenada nueva"
        annotation.subtitle = "creada por el usuario"
        
        self.map.addAnnotation(annotation)//agrega los datos a map
        
    }

    override func viewDidLoad() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //presicion del GPS
        locationManager.requestWhenInUseAuthorization()//solicite cuando solo se está utilizando 
        locationManager.startUpdatingLocation()//actualiza la ubicacion
        self.map.showsUserLocation = true
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let latitude:CLLocationDegrees = 19.3766
        let longitude:CLLocationDegrees = -99.2542
        
        
        //tamaño de la aplitud del mapa en el dispoditivo
        let latDelta:CLLocationDegrees = 0.015
        let lonDelta:CLLocationDegrees = 0.015
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        
        //ponerle una etiqueta al punto de ubicacion
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Patio sta fe"
        annotation.subtitle = "Tomando cafe"
        
        map.addAnnotation(annotation)//agrega los datos a map
        
        
        //Reconoce cuando el usuario presiona un boton
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(_:)))
        lpgr.minimumPressDuration = 2
        map.addGestureRecognizer(lpgr)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let userLocation = locations.last!
       
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.015
        let lonDelta:CLLocationDegrees = 0.015
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

