//
//  ViewController.swift
//  OpenWeather
//
//  Created by LUCIANO WEHRLI on 15/4/16.
//  Copyright © 2016 LA NACION. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destVC = segue.destinationViewController as! ReportViewController
        
        if let currentSender = sender{
            switch currentSender.tag {
            case 1: //my current location
                destVC.cityTitle = "My location"
                break
            case 2: //Berlin
                destVC.longitude = citiesCoords["Berlin"]!["lat"]
                destVC.latitute = citiesCoords["Berlin"]!["lon"]
                destVC.cityTitle = "Berlin"
                break
            case 3: //Madrid
                destVC.longitude = citiesCoords["Madrid"]!["lat"]
                destVC.latitute = citiesCoords["Madrid"]!["lon"]
                destVC.cityTitle = "Madrid"
                break
            case 4: //Paris
                destVC.longitude = citiesCoords["Paris"]!["lat"]
                destVC.latitute = citiesCoords["Paris"]!["lon"]
                destVC.cityTitle = "Paris"
                break
            case 5: //London
                destVC.longitude = citiesCoords["London"]!["lat"]
                destVC.latitute = citiesCoords["London"]!["lon"]
                destVC.cityTitle = "London"
                break
            case 6: //New York
                destVC.longitude = citiesCoords["NY"]!["lat"]
                destVC.latitute = citiesCoords["NY"]!["lon"]
                destVC.cityTitle = "New York"
                break
            default:
                break
            }
        }
    }
    
    

}

