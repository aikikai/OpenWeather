//
//  MapViewController.swift
//  OpenWeather
//
//  Created by LUCIANO WEHRLI on 15/4/16.
//  Copyright © 2016 LA NACION. All rights reserved.
//

import UIKit
import CoreLocation

class ReportViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var temp: UILabel!
    @IBOutlet var hum: UILabel!
    @IBOutlet var clouds: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var sea_level: UILabel!    
    @IBOutlet var predictions: UITextView!
    @IBOutlet var city: UILabel!
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var mycoordinates: UILabel!
    
    var longitude : String?
    var latitute : String?
    var cityTitle : String?
    var locationManager : CLLocationManager!
    
    
    //MARK: LIVECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forecast"
        checkLocationMethod()
    }
    
    //MARK: REPORTING
    func checkLocationMethod(){
        if self.latitute == nil{ //My Current Location
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }else{
            //Fixed cities locations
            self.loadData()
        }
    }
    
    func loadData(){
        if let cityName = cityTitle{
            self.city.text = cityName
        }
        
        self.showActivityLoading()
        ForecastAPI().fetchData(latitute, longitude: longitude) { (weatherTempObj) in
            if let weatherObj = weatherTempObj{
                dispatch_async(dispatch_get_main_queue()) {
                    self.temp.text = "Now: \(weatherObj.temperature!)F - (\(weatherObj.temp_min!) / \(weatherObj.temp_max!))"
                    self.hum.text = "\(weatherObj.humidity!)%"
                    self.clouds.text = "\(weatherObj.clouds_porcentage!)%"
                    self.pressure.text = weatherObj.pressure!
                    if weatherObj.sea_level != ""{
                        self.sea_level.text = weatherObj.sea_level
                    }else{
                        self.sea_level.text = "no data about it"
                    }
                    
                    if !(weatherObj.predictions!.isEmpty){
                        var tempText = ""
                        for var pred in weatherObj.predictions!{
                            if let mainTxt = pred.main{
                                if let descTxt = pred.predict_description{
                                    let str : String = "\(mainTxt): \(descTxt)\n"
                                    tempText = tempText.stringByAppendingString(str)
                                }
                            }
                        }
                        self.predictions.text = tempText
                    }
                    self.hideActivityLoading()
                }
            }
            else{
                let alertView = UIAlertController(title: "Oops!", message: "There was some problem with the data source", preferredStyle: UIAlertControllerStyle.Alert)
                let AceptAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alertView.addAction(AceptAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: LOCATION MANAGER
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let point = locations.last{
            self.latitute = "\(point.coordinate.latitude)"
            self.longitude = "\(point.coordinate.longitude)"
            self.mycoordinates.text = "\(self.latitute!) lat. \(self.longitude!) lon."
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()
            self.loadData()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }

    //MARK: MISCELANEAS
    func hideActivityLoading(){
        activity.stopAnimating()
        activity.alpha = 0.0
    }
    
    func showActivityLoading(){
        activity.startAnimating()
        activity.alpha = 1.0
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
