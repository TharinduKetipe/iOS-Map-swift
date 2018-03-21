//
//  ViewController.swift
//  TestApp
//
//  Created by Tharindu Ketipearachchi on 11/25/17.
//  Copyright © 2017 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class HomeViewController: UIViewController , MKMapViewDelegate ,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    var cities: [NSManagedObject] = []
    var annotations: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.getCityData()
        
        self.hardCodeCityData()
        self.fetchCityData()
        self.showCities()
        
        
        locationManager = CLLocationManager()
        self.locationManager?.requestAlwaysAuthorization()
        mapView.delegate = self
        mapView.showsUserLocation = true;
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to initialize GPS: ",error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }

 
    


}

extension HomeViewController {
    func getCityData ()  {
        let client = APIClient()
        let cityListUrl = URL(string:Constants.baseUrl + APIRequestMetod.cityList)
        client.getCities(url: cityListUrl!, params: [:]) { (status, response) in
            print(status,response)
        }
        
        let url1 = URL(string:Constants.basUrl01 + APIRequestMetod.userList)
        client.getUserList(url: url1!, params: [:]) { (status, response) in
            print(status,response)
        }
}
    
    func saveData (name:String ,long:Double,lat:Double)  {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        

        
       
       let entity = NSEntityDescription.entity(forEntityName: "City", in: managedContext)!
        
        let city = NSManagedObject(entity: entity, insertInto: managedContext)
        
        
        city.setValue(name, forKeyPath: "name")
        city.setValue(long, forKeyPath: "long")
        city.setValue(lat, forKeyPath: "lat")
        
       
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func hardCodeCityData() {
        self.saveData(name: "Anuradhapura", long: 80.410922, lat: 8.345851)
        self.saveData(name: "Kandy", long: 80.63624, lat: 7.291075)
        self.saveData(name: "Trincomalee", long: 81.215706, lat: 8.587367)
    }
    
    func fetchCityData () {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
       
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "City")
        
        
        do {
            cities = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func showCities() {
        if (self.cities.count > 0) {
            for city in self.cities {
                let cityy:City = city as! City
                self.makePoint(name: (cityy.name)!, long: cityy.long, lat: cityy.lat)
            }
            self.mapView.showAnnotations(self.annotations, animated: true)
            //self.mapView.showAnnotations([self.annotations as! MKAnnotation], animated:true)
        }
    }
    
    func makePoint(name:String,long:Double,lat:Double) {
        var location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        var point = MKPointAnnotation()
        point.coordinate = location
        point.title = name
        self.annotations.append(point)
        
        
    }
}

